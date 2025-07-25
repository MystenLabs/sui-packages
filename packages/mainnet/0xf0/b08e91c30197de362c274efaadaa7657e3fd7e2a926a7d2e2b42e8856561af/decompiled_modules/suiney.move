module 0xf0b08e91c30197de362c274efaadaa7657e3fd7e2a926a7d2e2b42e8856561af::suiney {
    struct SUINEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINEY>(arg0, 6, b"SUINEY", b"Sydney SUIney", b"Ecosystem Intern", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1753463658036.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUINEY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINEY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

