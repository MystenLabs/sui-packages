module 0x42b305a1d18a0b46001645220313bff3e3c54f497b9cdaf3cc488080330088c7::usdte {
    struct USDTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDTE>(arg0, 6, b"USDTe", b"UnstoppableDonaldTrumpElonInu", b"UnstoppableDonaldTrumpElonInu ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_a_ae_a_2024_10_06_163123_f662bd9736.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDTE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDTE>>(v1);
    }

    // decompiled from Move bytecode v6
}

