module 0xe4b0049c8a167d2d0bfef3f410203cbc4ba925d3198b198835dc90ca3147585::grt {
    struct GRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRT>(arg0, 6, b"GRT", b"Grt Coin", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GRT>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRT>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GRT>>(v2);
    }

    // decompiled from Move bytecode v6
}

