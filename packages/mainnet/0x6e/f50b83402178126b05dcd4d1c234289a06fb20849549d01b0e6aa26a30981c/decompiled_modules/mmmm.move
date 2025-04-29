module 0x6ef50b83402178126b05dcd4d1c234289a06fb20849549d01b0e6aa26a30981c::mmmm {
    struct MMMM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMMM>(arg0, 9, b"MMMM", b"mmmm", b"mmmmmmmmmmmm", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://coinhublogos.9inch.io/1724653538838-chum.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MMMM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMMM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

