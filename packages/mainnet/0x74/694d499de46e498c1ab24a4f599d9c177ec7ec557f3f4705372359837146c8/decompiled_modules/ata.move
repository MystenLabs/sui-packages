module 0x74694d499de46e498c1ab24a4f599d9c177ec7ec557f3f4705372359837146c8::ata {
    struct ATA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATA>(arg0, 6, b"ATA", b"AAAAAAA", b"AAAAAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1750635334553.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ATA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

