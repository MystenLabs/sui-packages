module 0xc8d264ee8b57c29aa974a502fa761a7c00a43e84d63c052450a11d16f0d08e7d::danzo {
    struct DANZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DANZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DANZO>(arg0, 6, b"DANZO", b"DANZOSUI", x"2444414e5a4f206f662053554944414e5a4f2e20546865206669727374204d454d45464920746f6b656e2e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/r_Y6_ZD_68w_400x400_1_2c020b3547.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DANZO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DANZO>>(v1);
    }

    // decompiled from Move bytecode v6
}

