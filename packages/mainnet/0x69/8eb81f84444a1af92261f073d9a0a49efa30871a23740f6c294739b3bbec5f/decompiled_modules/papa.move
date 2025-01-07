module 0x698eb81f84444a1af92261f073d9a0a49efa30871a23740f6c294739b3bbec5f::papa {
    struct PAPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAPA>(arg0, 6, b"PAPA", b"Papa", b"The godfather of memes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731436247643.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAPA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAPA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

