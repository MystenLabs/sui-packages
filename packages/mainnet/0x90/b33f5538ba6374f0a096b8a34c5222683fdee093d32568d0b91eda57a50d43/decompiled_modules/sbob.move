module 0x90b33f5538ba6374f0a096b8a34c5222683fdee093d32568d0b91eda57a50d43::sbob {
    struct SBOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBOB>(arg0, 6, b"SBOB", b"SPONGEBOB", b"Whooooooo... Who lives at the bottom of the ocean? SpongeBob SquarePants.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/spongebob_29d35a2045.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

