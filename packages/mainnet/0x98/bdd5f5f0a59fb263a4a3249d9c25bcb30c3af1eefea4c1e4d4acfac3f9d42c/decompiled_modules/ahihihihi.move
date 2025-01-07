module 0x98bdd5f5f0a59fb263a4a3249d9c25bcb30c3af1eefea4c1e4d4acfac3f9d42c::ahihihihi {
    struct AHIHIHIHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AHIHIHIHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AHIHIHIHI>(arg0, 9, b"AHIHIHIHI", b"Ahihihi", b"Ahiiiii", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/53cffdfd-a86a-48f3-96ec-f555843f59bf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AHIHIHIHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AHIHIHIHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

