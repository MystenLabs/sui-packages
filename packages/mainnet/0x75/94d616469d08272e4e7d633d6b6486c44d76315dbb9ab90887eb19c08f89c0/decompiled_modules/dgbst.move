module 0x7594d616469d08272e4e7d633d6b6486c44d76315dbb9ab90887eb19c08f89c0::dgbst {
    struct DGBST has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGBST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGBST>(arg0, 9, b"DGBST", b"Doggoblast", b"DoggoBlast Coin is a playful and energetic meme cryptocurrency that embodies the spirit of fun and adventure. Featuring a cartoon dog riding a rocket, DoggoBlast ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6e9c42d7-ba92-4ea1-945d-cdf5ab3e0a9c-1000005296.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGBST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DGBST>>(v1);
    }

    // decompiled from Move bytecode v6
}

