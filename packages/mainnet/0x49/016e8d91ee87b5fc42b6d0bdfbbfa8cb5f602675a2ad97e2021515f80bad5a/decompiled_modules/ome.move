module 0x49016e8d91ee87b5fc42b6d0bdfbbfa8cb5f602675a2ad97e2021515f80bad5a::ome {
    struct OME has drop {
        dummy_field: bool,
    }

    fun init(arg0: OME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OME>(arg0, 9, b"OME", b"OnlyMeme", b"Only meme coins = OnlyFns", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a0fb8a1d-5a2b-4dc0-95c2-3a4b6b8f5997-IMG_5988.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OME>>(v1);
    }

    // decompiled from Move bytecode v6
}

