module 0x3acad3356b0c8474b2ee1446c9cd87f4b8f32a13fa0303ec43988c228899ec7::DOGE {
    struct DOGE has drop {
        dummy_field: bool,
    }

    public fun add(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DOGE>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            0x2::coin::deny_list_v2_add<DOGE>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
            v0 = v0 + 1;
        };
    }

    fun create_logo_url() : 0x2::url::Url {
        0x2::url::new_unsafe_from_bytes(b"https://unicoinsui.com/logo_uni")
    }

    fun init(arg0: DOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<DOGE>(arg0, 6, b"DOGE", b"DOGE", b"doge is everyone's favorite Yeti on Sui", 0x1::option::some<0x2::url::Url>(create_logo_url()), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGE>>(v2);
        0x2::coin::mint_and_transfer<DOGE>(&mut v3, 1000000 * 0x1::u64::pow(10, 6), 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGE>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<DOGE>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun remove(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DOGE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<DOGE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

