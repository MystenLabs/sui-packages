module 0x244091f73320c1fd2391f390a2d1e3267f2fd50f6df6a80bd68b77aabdc999d::ais {
    struct AIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIS>(arg0, 9, b"AIS", b"Aishy", b"Aistoken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1d19ed08-bee2-4bae-b4eb-077f1ab52f23.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

