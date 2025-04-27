module 0xd113118ef846c2d85dda904ad01ea0fe33194681fd54ba759020f41dbd121f14::btc_cyh_test {
    struct BTC_CYH_TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTC_CYH_TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTC_CYH_TEST>(arg0, 6, b"BTC_CYH_TEST", b"BTC_CYH_TEST", b"this is BTC_CYH_TEST", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTC_CYH_TEST>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<BTC_CYH_TEST>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BTC_CYH_TEST>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BTC_CYH_TEST>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

