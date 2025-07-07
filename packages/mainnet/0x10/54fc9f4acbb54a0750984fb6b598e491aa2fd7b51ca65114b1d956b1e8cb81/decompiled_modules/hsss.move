module 0x1054fc9f4acbb54a0750984fb6b598e491aa2fd7b51ca65114b1d956b1e8cb81::hsss {
    struct HSSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HSSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HSSS>(arg0, 6, b"HSSS", b"Happy Self Sucking Snake", x"546869732073617373792073657270656e742073656c662066656c6c6174657320746f20736174697366616374696f6e2c0a0a2d686173206175746f66656c6c6174696f20746f6b656e6f6d6963732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sassy_snake_769cd99f48.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HSSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HSSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

