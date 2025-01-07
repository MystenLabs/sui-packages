module 0x6389bc4c35604f8000787c4769e688109f2d5f10b9a8facc4dc816b812dc70f9::dps {
    struct DPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DPS>(arg0, 9, b"DPS", b"bali", b"bali token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/61a21c96-ea50-4a5a-901a-39c3ed70149d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

