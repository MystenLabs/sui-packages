module 0x5224da49d8396d9e51bbbb0817f7d20ae9d24884603932613134d53d930838ea::woo {
    struct WOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOO>(arg0, 9, b"WOO", b"WOO", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/rnBeJDj0gj_CRa-FIH11P6x27n5y41WkATlbewLI1dA")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WOO>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOO>>(v2, @0x383b115cb98f749c31dbbe72cca01dd974114ae3a005afde2d745c0afd0bf846);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

