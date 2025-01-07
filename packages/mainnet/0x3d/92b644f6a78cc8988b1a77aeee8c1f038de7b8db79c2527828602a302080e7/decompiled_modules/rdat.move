module 0x3d92b644f6a78cc8988b1a77aeee8c1f038de7b8db79c2527828602a302080e7::rdat {
    struct RDAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RDAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RDAT>(arg0, 9, b"RDAT", b"RDA", b"Forfun create mission ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/54b3f170-6161-4067-9b3a-69dc5a5b6c34.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RDAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RDAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

