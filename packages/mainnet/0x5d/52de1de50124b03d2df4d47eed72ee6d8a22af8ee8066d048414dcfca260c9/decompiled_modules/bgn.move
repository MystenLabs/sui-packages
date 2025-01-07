module 0x5d52de1de50124b03d2df4d47eed72ee6d8a22af8ee8066d048414dcfca260c9::bgn {
    struct BGN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BGN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BGN>(arg0, 9, b"BGN", b"Bangin", b"It's just really been GOD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2deaff57-31a8-4063-86b6-3dc6a023cfa0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BGN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BGN>>(v1);
    }

    // decompiled from Move bytecode v6
}

