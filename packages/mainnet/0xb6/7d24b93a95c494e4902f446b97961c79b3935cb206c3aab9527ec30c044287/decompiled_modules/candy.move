module 0xb67d24b93a95c494e4902f446b97961c79b3935cb206c3aab9527ec30c044287::candy {
    struct CANDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CANDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CANDY>(arg0, 6, b"CANDY", b"Candy on sui", b"SUINS giving free candy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731521120673.jfif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CANDY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CANDY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

