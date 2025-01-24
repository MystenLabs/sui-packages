module 0xd4a376060980e7b47a157ff95856f4e17a973a28f9333039b5192b957f95a0be::vn {
    struct VN has drop {
        dummy_field: bool,
    }

    fun init(arg0: VN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VN>(arg0, 9, b"VN", b"Viet Nam", b"MeMe of Viet Nam country !!! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fb6931c6-1650-4fe2-ab7e-52928a2bd914.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VN>>(v1);
    }

    // decompiled from Move bytecode v6
}

