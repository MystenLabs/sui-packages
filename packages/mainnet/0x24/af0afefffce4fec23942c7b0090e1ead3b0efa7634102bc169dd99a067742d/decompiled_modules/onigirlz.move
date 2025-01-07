module 0x24af0afefffce4fec23942c7b0090e1ead3b0efa7634102bc169dd99a067742d::onigirlz {
    struct ONIGIRLZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONIGIRLZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONIGIRLZ>(arg0, 9, b"ONIGIRLZ", b"Sui Onigirlz", b"Let me introduce to you those two Oni cuties", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/039/412/759/large/hugo-lucas-onigirls-color-02.jpg?1625825921")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ONIGIRLZ>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONIGIRLZ>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ONIGIRLZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

