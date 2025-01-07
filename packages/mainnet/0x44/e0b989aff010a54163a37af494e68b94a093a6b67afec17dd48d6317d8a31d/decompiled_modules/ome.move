module 0x44e0b989aff010a54163a37af494e68b94a093a6b67afec17dd48d6317d8a31d::ome {
    struct OME has drop {
        dummy_field: bool,
    }

    fun init(arg0: OME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OME>(arg0, 9, b"OME", b"OnlyMeme", b"Only meme coins = OnlyFns", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dcceda9c-a483-4f36-a81d-6c52015e143e-IMG_5988.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OME>>(v1);
    }

    // decompiled from Move bytecode v6
}

