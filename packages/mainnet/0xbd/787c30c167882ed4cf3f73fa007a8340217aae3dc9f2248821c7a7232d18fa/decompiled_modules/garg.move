module 0xbd787c30c167882ed4cf3f73fa007a8340217aae3dc9f2248821c7a7232d18fa::garg {
    struct GARG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GARG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GARG>(arg0, 6, b"GARG", b"GARGOYLE", b"Neapolitan Mastiff: Dog Breed Info, Pictures, Traits & Care", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/th_1_6e39deb2eb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GARG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GARG>>(v1);
    }

    // decompiled from Move bytecode v6
}

