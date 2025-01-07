module 0xb43951d8bb113692b4878d427eeddf5eb818d0bbc3eb72febe7f7044881d6f09::hamsa {
    struct HAMSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAMSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAMSA>(arg0, 0, b"HAMSA", b"HAMSA", b"Utility token of the Stashdrop ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://stashdrop.org/assets/tokens/hamsa.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HAMSA>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAMSA>>(v2, @0xd27cc4a3a53b74e3abebb100949839d37d21264ad7616f7653019803fc43a046);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAMSA>>(v1);
    }

    // decompiled from Move bytecode v6
}

