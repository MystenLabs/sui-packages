module 0xb2ee3c405c9cc6c6815fbb2cdb37a94cedc8d4a65acefd77fd96881db19631be::suipark {
    struct SUIPARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPARK>(arg0, 6, b"SUIPARK", b"SUI PARK", b"Friendly faces everwhere humble folks without temptation!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731010804325.PNG")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPARK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPARK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

