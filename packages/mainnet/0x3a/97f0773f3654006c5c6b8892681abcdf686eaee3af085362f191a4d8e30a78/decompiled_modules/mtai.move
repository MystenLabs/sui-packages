module 0x3a97f0773f3654006c5c6b8892681abcdf686eaee3af085362f191a4d8e30a78::mtai {
    struct MTAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTAI>(arg0, 9, b"MTAI", b"Meta AI", b"This is a feature for AI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3c816316-34ec-4497-8d0a-20d8c317e75d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MTAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

