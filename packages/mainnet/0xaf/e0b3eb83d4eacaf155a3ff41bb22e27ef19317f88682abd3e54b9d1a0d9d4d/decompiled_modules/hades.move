module 0xafe0b3eb83d4eacaf155a3ff41bb22e27ef19317f88682abd3e54b9d1a0d9d4d::hades {
    struct HADES has drop {
        dummy_field: bool,
    }

    fun init(arg0: HADES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HADES>(arg0, 9, b"Hades", b"Hades Coin", b"Hades Coin come from ForgoTTen Code Universe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/17a62082b0bacb013188e16f5da64721blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HADES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HADES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

