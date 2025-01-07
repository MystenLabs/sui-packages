module 0xbc644f0d185485ec6ac93864f2b405497f052a44fb4525d3e1ac69948c7a8fd8::nomk {
    struct NOMK has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOMK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOMK>(arg0, 9, b"NOMK", b"NotMusk_20", x"4a75737420466f722046756e20f09f988a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ce8d0802-3231-4eb8-b1f2-1b24100b99e3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOMK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOMK>>(v1);
    }

    // decompiled from Move bytecode v6
}

