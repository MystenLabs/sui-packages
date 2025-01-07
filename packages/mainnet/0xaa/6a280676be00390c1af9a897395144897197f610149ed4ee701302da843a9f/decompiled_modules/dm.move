module 0xaa6a280676be00390c1af9a897395144897197f610149ed4ee701302da843a9f::dm {
    struct DM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DM>(arg0, 9, b"DM", b"Dam", b"Dam culture", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9326c6e4-7f90-469e-b3ac-4831b7d35d3b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DM>>(v1);
    }

    // decompiled from Move bytecode v6
}

