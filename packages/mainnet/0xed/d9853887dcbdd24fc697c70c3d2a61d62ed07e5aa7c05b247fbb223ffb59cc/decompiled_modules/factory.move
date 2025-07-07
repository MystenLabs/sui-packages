module 0xedd9853887dcbdd24fc697c70c3d2a61d62ed07e5aa7c05b247fbb223ffb59cc::factory {
    struct FACTORY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FACTORY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FACTORY>(arg0, 9, b"symbolUSD", b"nameUSD", b"descriptionUSD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"iconUSD")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FACTORY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FACTORY>>(v1);
    }

    // decompiled from Move bytecode v6
}

