module 0x1544a32c203a1930c844ddd0c78c4864d64b833095abe47c58037b78533ab2c5::lgd {
    struct LGD has drop {
        dummy_field: bool,
    }

    fun init(arg0: LGD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LGD>(arg0, 9, b"LGD", b"LegionDog", b"LegionDog is on top ==>", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/30581ff5-6f88-4f2d-8c1f-8a193be37c0b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LGD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LGD>>(v1);
    }

    // decompiled from Move bytecode v6
}

