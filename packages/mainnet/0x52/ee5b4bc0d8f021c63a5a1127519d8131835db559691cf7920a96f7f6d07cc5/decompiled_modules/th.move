module 0x52ee5b4bc0d8f021c63a5a1127519d8131835db559691cf7920a96f7f6d07cc5::th {
    struct TH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TH>(arg0, 9, b"TH", b"Amir", b"For buy nft", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0beef1fe-8368-4aca-8ad9-ecf9d2cc4eab.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TH>>(v1);
    }

    // decompiled from Move bytecode v6
}

