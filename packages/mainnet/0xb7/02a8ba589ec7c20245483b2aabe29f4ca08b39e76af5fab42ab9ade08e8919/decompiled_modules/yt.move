module 0xb702a8ba589ec7c20245483b2aabe29f4ca08b39e76af5fab42ab9ade08e8919::yt {
    struct YT has drop {
        dummy_field: bool,
    }

    fun init(arg0: YT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YT>(arg0, 9, b"YT", b"HG", b"XB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/03a06ede-8f29-4942-904c-05693b57bab2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YT>>(v1);
    }

    // decompiled from Move bytecode v6
}

