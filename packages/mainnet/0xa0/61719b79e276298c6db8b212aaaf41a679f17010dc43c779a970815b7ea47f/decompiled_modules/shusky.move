module 0xa061719b79e276298c6db8b212aaaf41a679f17010dc43c779a970815b7ea47f::shusky {
    struct SHUSKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHUSKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHUSKY>(arg0, 9, b"SHUSKY", b"HUSKY", b"Husky dogs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dba042bd-5179-43ea-93a2-99d9b176fd83.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHUSKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHUSKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

