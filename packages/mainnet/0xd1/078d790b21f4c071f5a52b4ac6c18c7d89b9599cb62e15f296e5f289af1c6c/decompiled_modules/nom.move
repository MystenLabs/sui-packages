module 0xd1078d790b21f4c071f5a52b4ac6c18c7d89b9599cb62e15f296e5f289af1c6c::nom {
    struct NOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOM>(arg0, 6, b"Nom", b"Normie", b"Sui Normie", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/normme_b8cb2b5df4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

