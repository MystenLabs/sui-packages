module 0x4da32937488b5ce5b9ed1b8a3bd69f4ab4ef570c8a8853cb490d13d4fda119d::justmeme {
    struct JUSTMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUSTMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUSTMEME>(arg0, 6, b"Justmeme", b"911", b"I am currently shitting. Remind me to add description later", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Osama_bin_Laden_portrait_afabc1bb7b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUSTMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUSTMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

