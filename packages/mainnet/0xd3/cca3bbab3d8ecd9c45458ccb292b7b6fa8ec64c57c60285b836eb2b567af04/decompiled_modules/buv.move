module 0xd3cca3bbab3d8ecd9c45458ccb292b7b6fa8ec64c57c60285b836eb2b567af04::buv {
    struct BUV has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUV>(arg0, 9, b"BUV", b"Buvy", b"Bull power", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/78e96d84-c61c-4a24-bb63-0a5bb926e043.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUV>>(v1);
    }

    // decompiled from Move bytecode v6
}

