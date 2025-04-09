module 0x121ee6c70b15bab2176d6cf045c200cf33205c3cbb6e33c178e0d156d2d810fe::byrn {
    struct BYRN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BYRN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BYRN>(arg0, 9, b"BYRN", b"bayern", b"FC Bayern ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/017946a18e8b7dd43b6e4e98dcc1c411blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BYRN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BYRN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

