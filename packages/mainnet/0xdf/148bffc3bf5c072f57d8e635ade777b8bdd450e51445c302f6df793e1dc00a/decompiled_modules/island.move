module 0xdf148bffc3bf5c072f57d8e635ade777b8bdd450e51445c302f6df793e1dc00a::island {
    struct ISLAND has drop {
        dummy_field: bool,
    }

    fun init(arg0: ISLAND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ISLAND>(arg0, 9, b"Island", b"The Endgame", b"After House gave you the keys, and Land claimed your acre, Island is the dream. The Endgame. Own not just property, but paradise. One token, one island, one life on your terms", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmf3A2P55ULEHXRTfCFC2FUmKi9FQMX3LC8nDxC5pmPJYd")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ISLAND>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ISLAND>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ISLAND>>(v1);
    }

    // decompiled from Move bytecode v6
}

