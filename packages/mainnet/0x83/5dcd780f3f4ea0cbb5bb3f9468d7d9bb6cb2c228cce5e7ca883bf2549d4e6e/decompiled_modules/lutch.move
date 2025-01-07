module 0x835dcd780f3f4ea0cbb5bb3f9468d7d9bb6cb2c228cce5e7ca883bf2549d4e6e::lutch {
    struct LUTCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUTCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUTCH>(arg0, 6, b"LUTCH", b"LutchCoin", b"Official Token for Matt Lutch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732641106764.com")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUTCH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUTCH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

