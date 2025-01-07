module 0x1188c28a8b8c4281c63a6dc49def1ea9b99a73b85a614764d7232b3a9a2398a0::monkey {
    struct MONKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONKEY>(arg0, 9, b"MONKEY", b"Tropikal Monkey", b"Mascot Sui ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/510/032/large/julie-bijjou-2024-monkey-coco-aymeric-bages-concept-eranalboher-003-bamboo-insta-ld-2.jpg?1727776268")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MONKEY>(&mut v2, 5000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONKEY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

