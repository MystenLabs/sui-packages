module 0x4fa3f60820bbdfdfd902e11873d0a5f4695882641ad591451af61e9e0c23b61e::rtfrog {
    struct RTFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: RTFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RTFROG>(arg0, 9, b"RTFROG", b"RocketFrog", b"This Frog will make you fly to the space with her Rocket", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b5646c23-f804-4d7f-a612-5ef1a421408a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RTFROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RTFROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

