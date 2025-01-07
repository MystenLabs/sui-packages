module 0xd49ccfaa2acf90060a201a65f28693fc8f6b0a679223eb7046aaa8088e307b12::watar {
    struct WATAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: WATAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WATAR>(arg0, 9, b"WATAR", b"WAVE AVATA", b"Meme avatar  sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/af8ab524-12a8-4657-be80-347372b5503f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WATAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

