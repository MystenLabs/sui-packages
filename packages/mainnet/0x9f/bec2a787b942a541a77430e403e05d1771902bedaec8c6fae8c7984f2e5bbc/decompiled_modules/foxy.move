module 0x9fbec2a787b942a541a77430e403e05d1771902bedaec8c6fae8c7984f2e5bbc::foxy {
    struct FOXY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOXY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOXY>(arg0, 9, b"FOXY", b"Foxy", b"Foxy is the mascot to Sui, and the first ever culturecoin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1760315148554719232/rFqznUYb_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FOXY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOXY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOXY>>(v1);
    }

    // decompiled from Move bytecode v6
}

