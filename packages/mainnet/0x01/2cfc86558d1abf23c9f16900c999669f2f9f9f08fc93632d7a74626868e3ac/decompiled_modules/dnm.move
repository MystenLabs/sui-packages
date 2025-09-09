module 0x12cfc86558d1abf23c9f16900c999669f2f9f9f08fc93632d7a74626868e3ac::dnm {
    struct DNM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DNM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DNM>(arg0, 5, b"DNM", b"dnm", b"222", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.kraken.com/marketing/web/icons-uni-webp/s_inj.webp")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DNM>(&mut v2, 1234500000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DNM>>(v2, @0xa4dee7e7d6686865508d157f233d3203232efb9744843743704564b718f0dcf4);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DNM>>(v1);
    }

    // decompiled from Move bytecode v6
}

