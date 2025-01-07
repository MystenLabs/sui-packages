module 0xc9da88e5a01563f69bddc06402f80159213f68bda7ce499b666464675e13a089::syn {
    struct SYN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYN>(arg0, 6, b"SYN", b"SUI SYNDICATE", b"Plotting to takeover the meme world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730952942026.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SYN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

