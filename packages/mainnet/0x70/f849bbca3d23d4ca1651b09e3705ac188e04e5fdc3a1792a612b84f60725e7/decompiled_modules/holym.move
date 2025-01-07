module 0x70f849bbca3d23d4ca1651b09e3705ac188e04e5fdc3a1792a612b84f60725e7::holym {
    struct HOLYM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLYM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOLYM>(arg0, 9, b"HOLYM", b"Holymeme", b"A memecoin created solely for the fun of it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e1d9d566-9c83-4856-adae-fb8d75409fc4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLYM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOLYM>>(v1);
    }

    // decompiled from Move bytecode v6
}

