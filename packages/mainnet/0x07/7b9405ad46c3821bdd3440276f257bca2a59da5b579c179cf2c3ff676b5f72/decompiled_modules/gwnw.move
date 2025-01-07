module 0x77b9405ad46c3821bdd3440276f257bca2a59da5b579c179cf2c3ff676b5f72::gwnw {
    struct GWNW has drop {
        dummy_field: bool,
    }

    fun init(arg0: GWNW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GWNW>(arg0, 9, b"GWNW", b"bden", b"ndnd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/feecdfaf-3e34-4d2e-8574-f1ce8ccb9503.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GWNW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GWNW>>(v1);
    }

    // decompiled from Move bytecode v6
}

