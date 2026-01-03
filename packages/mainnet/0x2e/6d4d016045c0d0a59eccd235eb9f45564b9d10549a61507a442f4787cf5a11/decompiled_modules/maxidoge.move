module 0x2e6d4d016045c0d0a59eccd235eb9f45564b9d10549a61507a442f4787cf5a11::maxidoge {
    struct MAXIDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAXIDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAXIDOGE>(arg0, 6, b"MAXIDOGE", b"Maxi Doge", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MAXIDOGE>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAXIDOGE>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MAXIDOGE>>(v2);
    }

    // decompiled from Move bytecode v6
}

