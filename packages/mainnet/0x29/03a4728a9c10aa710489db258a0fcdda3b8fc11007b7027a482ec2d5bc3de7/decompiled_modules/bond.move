module 0x2903a4728a9c10aa710489db258a0fcdda3b8fc11007b7027a482ec2d5bc3de7::bond {
    struct BOND has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOND>(arg0, 5, b"BOND", b"BOND", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d2w9m16hs9jc37.cloudfront.net/dimg/blog/2023/07/hockerty_sean_connery_james_bond_8c9de868_2912_4a4e_a539_2ecda28d3ab4.jpg")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<BOND>(&mut v2, 9000000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOND>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOND>>(v1);
    }

    // decompiled from Move bytecode v6
}

