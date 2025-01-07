module 0x595009d221b095c72226fcd3ca802c9131d858c4cf5b8561439bb3c868348814::tump {
    struct TUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUMP>(arg0, 6, b"TUMP", b"Turbo Trump", b"Trump is in a rush to MAGA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731074724804.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUMP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

