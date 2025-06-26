module 0xbf907d79198d32ebb45aa1047d594ed8aa58c23f5df66b57f87f59f5cd4263ef::bg {
    struct BG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BG>(arg0, 6, b"BG", b"BIG", b"BIG BIG BIG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigg64bd3b6vg5zwbmnwtewrm7ho7z2c54ioekxfct6cz6sfggopae")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

