module 0xe4589739e6e4b4f590840f1af4c8eb6bc84d3fcd941f174a4d999619ec2eb5e2::money {
    struct MONEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONEY>(arg0, 9, b"MONEY", b"MOney", b"The coin named after the man, the myth, the Mo. No promises. No roadmaps. Just pure community-driven fun with a touch of Shaikh energy. Join the cult of $MONEY. Shaikh it till you make it. | Website: https://i.imgur.com/gZWk8qf.jpeg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/gZWk8qf.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

