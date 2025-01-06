module 0x29cb4ea7ce569c56e8daf880a1a9c0b2df7d760708a2bc3ec64eae11f2cfad34::fgt {
    struct FGT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FGT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FGT>(arg0, 9, b"FGT", b"FLOWER", b"FLOWERRRRRR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/45ce57b5-b7cf-44d5-8ea9-a2f41fca663f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FGT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FGT>>(v1);
    }

    // decompiled from Move bytecode v6
}

