module 0x974fe1dea4f6bc8a7404946fccdafc695c3af0e046f0a3a365f0963366ae24a2::mtai {
    struct MTAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTAI>(arg0, 9, b"MTAI", b"Meta AI", b"This is a feature for AI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/00d5849b-21e7-484d-85b7-4b0ff190bbcc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MTAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

