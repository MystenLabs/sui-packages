module 0xa851a2460db0f8a176f113e1bdd6b2cf57a0968fb107cac14361fb3bdbc2c3a2::walcat {
    struct WALCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALCAT>(arg0, 6, b"Walcat", b"Walrus Cat", x"5374657665203a203a2046502020736169643a0a2249207375636365737366756c6c792075706c6f61646564206d7920636174277320706963747572657320746f204057616c72757350726f746f636f6c2076696120405475736b79546f6f6c732e220a0a4e6f204465762e20557020746f2074686520636f6d6d756e69747920746f2072756e204d656f77", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ggrcbama_MA_Ab_B_Wh_2dfae5d1d6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WALCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

