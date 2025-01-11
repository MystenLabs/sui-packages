module 0xea1eb5b7e1e18b27895060b0e6a7fdc301b1ee1cce1ad375460ee3020e157475::fai {
    struct FAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<FAI>(arg0, 6, b"FAI", b"Five.agentAI by SuiAI", x"464956453a204661737420496e74656c6c6967656e63652c20566173742045766f6c7574696f6e20e280932074686520746f6b656e20706f776572696e672074686520667574757265206f66204167656e742041492e2e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000022495_ad9ad52dd1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

