module 0xcde1d907e3f1b39b84d5e900d067c6d74ac038ac8026764f8085387133c67860::cowboy {
    struct COWBOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: COWBOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COWBOY>(arg0, 6, b"COWBOY", b"Cowboy Sui", b"$COWBOY on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000439_79e8976189.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COWBOY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COWBOY>>(v1);
    }

    // decompiled from Move bytecode v6
}

