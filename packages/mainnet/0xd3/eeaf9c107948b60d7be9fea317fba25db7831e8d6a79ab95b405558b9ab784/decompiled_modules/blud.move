module 0xd3eeaf9c107948b60d7be9fea317fba25db7831e8d6a79ab95b405558b9ab784::blud {
    struct BLUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUD>(arg0, 6, b"BLUD", b"Sui Blud", b"Meet $BLUD | Latest SUI Mascot building a new Meta.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730996825671.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

