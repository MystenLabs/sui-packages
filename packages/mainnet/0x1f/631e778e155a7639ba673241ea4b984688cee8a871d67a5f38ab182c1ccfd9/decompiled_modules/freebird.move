module 0x1f631e778e155a7639ba673241ea4b984688cee8a871d67a5f38ab182c1ccfd9::freebird {
    struct FREEBIRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FREEBIRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FREEBIRD>(arg0, 9, b"FREEBIRD", b"FreeBird", b"Be a FREE BIRD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ec7d7276-3fd4-4c89-816b-929ceac0cd08.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FREEBIRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FREEBIRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

