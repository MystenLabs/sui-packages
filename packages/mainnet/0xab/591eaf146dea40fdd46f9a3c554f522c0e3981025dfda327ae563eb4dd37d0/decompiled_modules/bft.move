module 0xab591eaf146dea40fdd46f9a3c554f522c0e3981025dfda327ae563eb4dd37d0::bft {
    struct BFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BFT>(arg0, 9, b"BFT", b"BABY FAT", b"NINI BABY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2d90c8f2-2391-44f5-945b-636801a77c05.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BFT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BFT>>(v1);
    }

    // decompiled from Move bytecode v6
}

