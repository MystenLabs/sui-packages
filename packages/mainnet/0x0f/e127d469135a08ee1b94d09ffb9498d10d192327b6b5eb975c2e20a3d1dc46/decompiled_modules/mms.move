module 0xfe127d469135a08ee1b94d09ffb9498d10d192327b6b5eb975c2e20a3d1dc46::mms {
    struct MMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMS>(arg0, 6, b"MMS", b"MermaidMans", b"Ernie (or Jim) Huckler, better known by his superhero name Mermaid Man, is a semi-retired superhero who lives in Bikini Bottom. He and his sidekick Barnacle Boy are the stars of a show-within-a-show called The Adventures of Mermaid Man and Barnacle Boy, but they are also real superheroes within the SpongeBob SquarePants universe.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sdkaoka_1463e0ce49.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

