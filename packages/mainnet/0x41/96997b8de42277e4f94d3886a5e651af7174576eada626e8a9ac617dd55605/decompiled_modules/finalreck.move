module 0x4196997b8de42277e4f94d3886a5e651af7174576eada626e8a9ac617dd55605::finalreck {
    struct FINALRECK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FINALRECK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FINALRECK>(arg0, 9, b"FINALRECK", b"Mission: Impossible, The Final Reckoning", x"4f7572206c6976657320617265207468652073756d206f66206f75722063686f696365732e20546f6d2043727569736520697320457468616e2048756e7420696e204d697373696f6e3a20496d706f737369626c6520e28093205468652046696e616c205265636b6f6e696e672e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://a1.moviepassblack.com/w3/assets/FINALRECK.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FINALRECK>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FINALRECK>>(v2, @0xebc707141970574ece90991112fe9a682d03b1596db6ca8981a29f385cbf76d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FINALRECK>>(v1);
    }

    // decompiled from Move bytecode v6
}

