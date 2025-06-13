module 0x8b92e5bb8dab054b949da801387ff2b2baf0f90609ed422ae9a70b310eea8082::wet {
    struct WET has drop {
        dummy_field: bool,
    }

    fun init(arg0: WET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WET>(arg0, 6, b"WET", b"Wet", x"6120746f6b656e2e2061206361742e20612073756d6d65722063756c742e0a776574277265206561726c7921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x9c84d78839ade4d3211a9b5fa73ef079eca4f739_ff382c7a12.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WET>>(v1);
    }

    // decompiled from Move bytecode v6
}

