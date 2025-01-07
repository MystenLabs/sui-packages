module 0xf3daa786e2db4b0a719885733254c567f0b0c565e91263bc723b2e3babcf5717::suibob {
    struct SUIBOB has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIBOB>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIBOB>>(0x2::coin::mint<SUIBOB>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUIBOB>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SUIBOB>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SUIBOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SUIBOB>(arg0, 9, b"SuiBob", b"Sponge SuiBob", b"Sponge bob meme on SUI Sponge SuiBob", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRTNd1aYLi6goJv0PQiZP-1UQHEsd4HOL1yTg&s")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<SUIBOB>(&mut v3, 9000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIBOB>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBOB>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SUIBOB>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUIBOB>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SUIBOB>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

