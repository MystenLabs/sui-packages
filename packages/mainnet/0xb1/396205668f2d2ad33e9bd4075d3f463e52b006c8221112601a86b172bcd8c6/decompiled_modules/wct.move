module 0xb1396205668f2d2ad33e9bd4075d3f463e52b006c8221112601a86b172bcd8c6::wct {
    struct WCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WCT>(arg0, 9, b"WCT", b"WAKA", b"Electronic sigarette vaping coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1b1fd30a-ca15-420d-b83b-0c1f32392f7b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WCT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WCT>>(v1);
    }

    // decompiled from Move bytecode v6
}

