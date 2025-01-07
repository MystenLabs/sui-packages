module 0xae35308000aa8beff60782a36a453b1987007c6926882429234a3d26c3a4530a::rosemas {
    struct ROSEMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROSEMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROSEMAS>(arg0, 6, b"Rosemas", b"Rosemas Sui", b"Merry Rosemas", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Rosemas_PNG_removebg_preview_f0fa1f4027.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROSEMAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROSEMAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

