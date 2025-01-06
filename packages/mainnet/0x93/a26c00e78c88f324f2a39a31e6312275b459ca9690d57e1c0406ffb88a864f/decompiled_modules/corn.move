module 0x93a26c00e78c88f324f2a39a31e6312275b459ca9690d57e1c0406ffb88a864f::corn {
    struct CORN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CORN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CORN>(arg0, 6, b"Corn", b"CornHub", b"Your Favourite Site To Visit When You Feeling Corny ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736130659512.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CORN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CORN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

