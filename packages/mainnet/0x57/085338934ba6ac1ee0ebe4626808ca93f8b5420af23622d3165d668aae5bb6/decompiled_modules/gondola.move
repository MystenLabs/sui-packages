module 0x57085338934ba6ac1ee0ebe4626808ca93f8b5420af23622d3165d668aae5bb6::gondola {
    struct GONDOLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GONDOLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GONDOLA>(arg0, 6, b"GONDOLA", b"SUI Gondola", b"The two legged cutie we all know and love on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/12313_d978c3a1eb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GONDOLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GONDOLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

