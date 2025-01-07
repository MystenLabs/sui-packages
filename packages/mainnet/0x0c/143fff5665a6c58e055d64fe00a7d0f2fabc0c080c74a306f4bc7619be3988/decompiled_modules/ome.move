module 0xc143fff5665a6c58e055d64fe00a7d0f2fabc0c080c74a306f4bc7619be3988::ome {
    struct OME has drop {
        dummy_field: bool,
    }

    fun init(arg0: OME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OME>(arg0, 9, b"OME", b"OnlyMeme", b"Only meme coins = OnlyFns", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/654f0fc8-c209-492a-b33f-a47f1fff74d9-IMG_5988.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OME>>(v1);
    }

    // decompiled from Move bytecode v6
}

