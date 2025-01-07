module 0x195ca1eb8bc15deacaf3209139963f8e3ba6f2563ac733068908913b40bf87a5::sch {
    struct SCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCH>(arg0, 8, b" SCH", b"Sui Cash", b"Suicash is the epitome of wealth meets swag", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1735710548375859200/vxIbkU9__400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SCH>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

