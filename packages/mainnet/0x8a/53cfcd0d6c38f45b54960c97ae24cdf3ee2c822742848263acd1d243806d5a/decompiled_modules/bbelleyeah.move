module 0x8a53cfcd0d6c38f45b54960c97ae24cdf3ee2c822742848263acd1d243806d5a::bbelleyeah {
    struct BBELLEYEAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBELLEYEAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBELLEYEAH>(arg0, 6, b"Bbelleyeah", b"Baby elleyeah", b"Can I get a...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736816590300.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBELLEYEAH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBELLEYEAH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

