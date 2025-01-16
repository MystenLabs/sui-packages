module 0xc1ed87bb5592505ef061b6215c3d88ff5193277bb2df790184127a0d7fe9e0::bwa {
    struct BWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BWA>(arg0, 6, b"BWA", b"Blue Whale Agent", b"The Great Blue Whale Agent, just enjoy like her!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737048951857.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BWA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BWA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

