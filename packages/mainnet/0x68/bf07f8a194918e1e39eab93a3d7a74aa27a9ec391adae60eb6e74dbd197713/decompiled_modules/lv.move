module 0x68bf07f8a194918e1e39eab93a3d7a74aa27a9ec391adae60eb6e74dbd197713::lv {
    struct LV has drop {
        dummy_field: bool,
    }

    fun init(arg0: LV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LV>(arg0, 9, b"LV", b"LOVE", b"LOVE", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LV>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LV>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LV>>(v1);
    }

    // decompiled from Move bytecode v6
}

