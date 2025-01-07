module 0xcbc79335c0bf8ad3bf048342d6b385ea442a50acc40579c099a880f1e7584f1d::bcdf {
    struct BCDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BCDF>(arg0, 9, b"BCDF", b"Bvcd", b" Xxc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2ba2585e-3f73-449c-a22a-42370f7115b6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCDF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BCDF>>(v1);
    }

    // decompiled from Move bytecode v6
}

