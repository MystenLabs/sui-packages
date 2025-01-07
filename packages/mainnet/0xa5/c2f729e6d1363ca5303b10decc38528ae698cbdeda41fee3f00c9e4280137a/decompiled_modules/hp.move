module 0xa5c2f729e6d1363ca5303b10decc38528ae698cbdeda41fee3f00c9e4280137a::hp {
    struct HP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HP>(arg0, 9, b"HP", b"HIPO", b"Discover the thrilling world of HippoHaven! Join our NFT hippo herd on a unique adventure. Collect, breed, and trade your adorable hippos to win great rewards! Dive into the fun of HippoHaven today. Don't miss out on this opportunity!  #NFTGame #Hippos #AmazingRewards", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://th.bing.com/th/id/OIG4.8.r9ApAxDZU403r7TN8a?w=270&h=270&c=6&r=0&o=5&pid=ImgGn")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HP>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HP>>(v1);
    }

    // decompiled from Move bytecode v6
}

