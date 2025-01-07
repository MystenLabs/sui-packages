module 0x8b49990e6bac5d94633e7c97ab1e8fa37bdf0536cb18db6fde99dfd761b153db::bg {
    struct BG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BG>(arg0, 9, b"BG", b"Bidget", b"Bidgeter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4c357310-fa68-444c-bfcb-4f807f63258f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BG>>(v1);
    }

    // decompiled from Move bytecode v6
}

