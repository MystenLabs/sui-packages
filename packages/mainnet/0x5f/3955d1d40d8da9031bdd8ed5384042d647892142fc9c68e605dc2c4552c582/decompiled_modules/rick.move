module 0x5f3955d1d40d8da9031bdd8ed5384042d647892142fc9c68e605dc2c4552c582::rick {
    struct RICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICK>(arg0, 9, b"RICK", b"Rick coin", b"rick c-137", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8520c8ee-5cd3-488d-9eef-deae639f7998.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

