module 0x230def4b437a10102cd8a862ab82e9d079a64dbb0fd870ba4d519779ad0b680b::stash {
    struct STASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: STASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STASH>(arg0, 0, b"STASH", b"STASH", b"Utility token of the Stashdrop ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://stashdrop.org/assets/tokens/stash.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STASH>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STASH>>(v2, @0xd27cc4a3a53b74e3abebb100949839d37d21264ad7616f7653019803fc43a046);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

