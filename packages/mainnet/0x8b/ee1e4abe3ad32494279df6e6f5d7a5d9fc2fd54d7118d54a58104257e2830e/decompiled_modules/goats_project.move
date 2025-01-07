module 0x8bee1e4abe3ad32494279df6e6f5d7a5d9fc2fd54d7118d54a58104257e2830e::goats_project {
    struct GOATS_PROJECT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOATS_PROJECT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOATS_PROJECT>(arg0, 9, b"Goats Project", b"Goats Project", b"$Goats: A Sui crypto empowering social change through community voting, NFT creation, and donations to animal charities. Support creativity and compassion with every transaction on the blockchain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GOATS_PROJECT>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOATS_PROJECT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOATS_PROJECT>>(v1);
    }

    // decompiled from Move bytecode v6
}

