module 0x8a30333bad3cf0dee39799340a0b3f962359419c11b699ceb29e5ea0c9fa6c0a::bunny {
    struct BUNNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUNNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUNNY>(arg0, 9, b"BUNNY", b"Bunny hop", b"Royal Bunny", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1312b8af-bbf9-4613-a6b4-a774a64851f3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUNNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUNNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

