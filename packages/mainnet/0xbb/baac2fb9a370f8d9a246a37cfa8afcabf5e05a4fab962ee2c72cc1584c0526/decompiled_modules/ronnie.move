module 0xbbbaac2fb9a370f8d9a246a37cfa8afcabf5e05a4fab962ee2c72cc1584c0526::ronnie {
    struct RONNIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RONNIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RONNIE>(arg0, 6, b"RONNIE", b"Ronnie The Racoon", b"Ronnie is a mischievous little fella, he is constantly breaking into gardens, and this behavior needs to stop,, so lets gather a community that can help Ronnie, live a regular racoons life!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOGA_7748bd708d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RONNIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RONNIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

