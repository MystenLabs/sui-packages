module 0x8c39e27003022ef869460dc8187d5d4e7fe7968dd2f79e478c19e13b16d43460::timon {
    struct TIMON has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TIMON>, arg1: 0x2::coin::Coin<TIMON>) {
        0x2::coin::burn<TIMON>(arg0, arg1);
    }

    fun init(arg0: TIMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIMON>(arg0, 2, b"TIMON", b"TIMON", b"TIMON FRIENDS OF LION KING", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIMON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIMON>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TIMON>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TIMON>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

