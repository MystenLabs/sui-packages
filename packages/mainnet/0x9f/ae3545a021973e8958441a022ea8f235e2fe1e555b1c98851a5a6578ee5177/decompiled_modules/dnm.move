module 0x9fae3545a021973e8958441a022ea8f235e2fe1e555b1c98851a5a6578ee5177::dnm {
    struct DNM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DNM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DNM>(arg0, 5, b"DNM", b"DNM", b"TEST PURPOSE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.kraken.com/marketing/web/icons-uni-webp/s_inj.webp")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DNM>(&mut v2, 12345600000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DNM>>(v2, @0xa4dee7e7d6686865508d157f233d3203232efb9744843743704564b718f0dcf4);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DNM>>(v1);
    }

    // decompiled from Move bytecode v6
}

