module 0x58546dfeaea24f17d0a0f8fd2b96463529955314f900b08284287214c392e97e::mct {
    struct MCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCT>(arg0, 9, b"MCT", b"myCAT", b"my cat on PC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f22af095-e5a1-4734-817a-684da1933d77.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MCT>>(v1);
    }

    // decompiled from Move bytecode v6
}

