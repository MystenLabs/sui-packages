module 0x87bfb2b8bedd6c647a6f2f4ccc39303d12bbb7cb08044d3f278a886045cc5f45::fuk {
    struct FUK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<FUK>(arg0, 6, 0x1::string::utf8(b"Fuk"), 0x1::string::utf8(b"Fuk Zuk"), 0x1::string::utf8(x"6d65746120e2869220337820e28692207a756b20e286922066756b"), 0x1::string::utf8(b"https://fartpadsui.fun/token-images/fuk.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUK>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<FUK>>(0x2::coin_registry::finalize<FUK>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

