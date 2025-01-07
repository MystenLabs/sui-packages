module 0xaf4b88460609eca51385c895d53edb4b83b64a325085088f0e5b05c98ec6ead4::tkf {
    struct TKF has drop {
        dummy_field: bool,
    }

    fun init(arg0: TKF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TKF>(arg0, 9, b"TKF", b"TalkFish", b"This fish can talk when it's out of water but his life is too short.HELP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8f0d8e2e-04f9-4a60-9791-e1ae0a39d08d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TKF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TKF>>(v1);
    }

    // decompiled from Move bytecode v6
}

