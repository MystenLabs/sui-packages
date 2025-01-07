module 0xc9c1fa38c815a9f6382239bdfd39b28394b5782334b1d679df6b1ad50227a77b::barsik {
    struct BARSIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARSIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARSIK>(arg0, 6, b"BARSIK", x"48617362756c6ce2809973204361742042415253494b", x"496e20746865206d656d6f7279206f662048617362756c6ce28099732063757465204361742042415253494b2e0a524950", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731860117266.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BARSIK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARSIK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

