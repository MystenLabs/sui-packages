module 0xe43ba9265ea4ca883df59f1d2b3d17a096957a0a3d1e810a158904fc07b4647b::pignose {
    struct PIGNOSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIGNOSE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PIGNOSE>(arg0, 6, b"PIGNOSE", b"PIG NOSE", b"SuiEmoji Pig Nose", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.suiemoji.fun/emojis/pignose.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PIGNOSE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIGNOSE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

