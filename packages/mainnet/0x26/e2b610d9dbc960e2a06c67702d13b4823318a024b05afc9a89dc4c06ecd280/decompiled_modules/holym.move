module 0x26e2b610d9dbc960e2a06c67702d13b4823318a024b05afc9a89dc4c06ecd280::holym {
    struct HOLYM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLYM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOLYM>(arg0, 9, b"HOLYM", b"Holymeme", b"A memecoin created solely for the fun of it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/05b0374a-a1c7-4b48-9c15-3d6a056a6c54.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLYM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOLYM>>(v1);
    }

    // decompiled from Move bytecode v6
}

