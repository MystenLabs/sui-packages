module 0x71d3d5882e2b178d1103d9074d4074f3390aa8650898abb27715b91ee12c3811::brj {
    struct BRJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRJ>(arg0, 9, b"BRJ", b"Burjk", b"God's good", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ca3ab844-33bc-4506-9d7f-ff7f52a818b8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

