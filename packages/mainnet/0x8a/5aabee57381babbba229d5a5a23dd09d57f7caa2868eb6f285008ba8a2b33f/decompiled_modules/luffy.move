module 0x8a5aabee57381babbba229d5a5a23dd09d57f7caa2868eb6f285008ba8a2b33f::luffy {
    struct LUFFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUFFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUFFY>(arg0, 9, b"LUFFY", b"Luffy", b"It's strawhat luffy. The king of the pirates", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/63271bde-8e3d-4bd0-abc3-84b401852ac2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUFFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUFFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

