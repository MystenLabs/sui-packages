module 0xa4f81b2e9ef03fdc404a6d38be5887525e0b46b7116319a408d57857b6e73ac1::eggfish {
    struct EGGFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGGFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGGFISH>(arg0, 6, b"EGGFISH", b"Egg Fish", b"Egg Fish, unlike the solitary sharks and mighty whales, thrived by swimming together in great schools, using unity and agility to survive the ocean's dangers. In the end, it was not strength but cooperation and adaptability that brought them fortune.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mack_52201614da_700f1e2ce3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGGFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EGGFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

