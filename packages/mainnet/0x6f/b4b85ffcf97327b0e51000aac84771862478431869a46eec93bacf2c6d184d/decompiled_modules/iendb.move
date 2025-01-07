module 0x6fb4b85ffcf97327b0e51000aac84771862478431869a46eec93bacf2c6d184d::iendb {
    struct IENDB has drop {
        dummy_field: bool,
    }

    fun init(arg0: IENDB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IENDB>(arg0, 9, b"IENDB", b"dhdn", b"hd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dc27c903-d9c4-411c-8e6a-98e3a85c5fbc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IENDB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IENDB>>(v1);
    }

    // decompiled from Move bytecode v6
}

