module 0xf5ee3c3b67969c496eebb0286895ee976a8a621569704110ba48c763d333acaf::doggo {
    struct DOGGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGGO>(arg0, 6, b"DOGGO", b"MEME DOGGO", b"DOGGO is a memecoin featuring a cheerful and friendly dog mascot, representing the playful and lighthearted nature of the project. With an expressive face, warm eyes, and a big smile, DOGGO embodies the welcoming and community-driven spirit of the coin. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/doggo_6fb86c5d7b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

