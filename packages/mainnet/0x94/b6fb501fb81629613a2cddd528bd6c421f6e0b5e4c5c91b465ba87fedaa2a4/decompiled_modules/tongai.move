module 0x94b6fb501fb81629613a2cddd528bd6c421f6e0b5e4c5c91b465ba87fedaa2a4::tongai {
    struct TONGAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TONGAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TONGAI>(arg0, 9, b"TONGAI", b"TongoDrop ", b"Meme coin of community Tongai", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/811087d0-f173-4429-ad61-dfcf3f2c3539.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TONGAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TONGAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

