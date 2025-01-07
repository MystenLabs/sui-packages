module 0x90caed5fb955c8da1fca83de32d8cafba2d931538a4d6ac89d7967f27b299047::spunk {
    struct SPUNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPUNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPUNK>(arg0, 6, b"SPUNK", b"SPUNK", x"546865206f6666696369616c20746f6b656e206f6620746865205375692050756e6b7320636f6c6c656374696f6e2e20446f6ee28099742066616c6c20666f7220746865206b6e6f636b6f66667320e28093206772616220796f757220245350554e4b206e6f772c2062656361757365206f6276696f75736c792c206974e280997320746865207265616c206465616c2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://bafybeifaicnh7ae4w6awgp7mbg7i4twd7ab2vsgk2gkhic2zyr5ijjgv4m.ipfs.w3s.link/%24SPUNK-WBG.png"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SPUNK>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPUNK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPUNK>>(v1);
    }

    // decompiled from Move bytecode v6
}

