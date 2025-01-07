module 0x3126cab6f6284f901ad10abf980216ef678eb4c056e76d1a523e40d5ac9cdf00::phd {
    struct PHD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PHD>(arg0, 6, b"PHD", b"Pretty Huge Dick ", b"TICKER: PHD | He's got a pretty huge dick ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733851824762.51")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PHD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

