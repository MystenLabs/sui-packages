module 0x99de31046372e858df5b124465b8c578e18ac585bab0ddf5a242b16b7bb4184e::tws {
    struct TWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWS>(arg0, 6, b"TWS", b"Tim WalSui", b"The face you make when you sold your bag of SUI at $.49", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/walz_152382407a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

