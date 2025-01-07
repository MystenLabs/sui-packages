module 0x487a23b729319f5dfc3c6b59c1da61449bf4916e23e1f1b7f4a283ea1169068d::mr {
    struct MR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MR>(arg0, 9, b"MR", b"Murakata", b"Good token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cb775afe-0d23-4227-a7f9-52f6447e1c3d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MR>>(v1);
    }

    // decompiled from Move bytecode v6
}

