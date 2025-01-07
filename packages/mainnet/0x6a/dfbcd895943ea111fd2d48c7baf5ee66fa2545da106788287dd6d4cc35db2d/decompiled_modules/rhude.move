module 0x6adfbcd895943ea111fd2d48c7baf5ee66fa2545da106788287dd6d4cc35db2d::rhude {
    struct RHUDE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<RHUDE>, arg1: 0x2::coin::Coin<RHUDE>) {
        0x2::coin::burn<RHUDE>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<RHUDE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<RHUDE>>(0x2::coin::mint<RHUDE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: RHUDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RHUDE>(arg0, 9, b"rhude", b"RHUDE", b"rhude is the test token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RHUDE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RHUDE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

