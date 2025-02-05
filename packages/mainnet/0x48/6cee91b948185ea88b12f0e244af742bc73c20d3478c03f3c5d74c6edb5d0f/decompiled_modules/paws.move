module 0x486cee91b948185ea88b12f0e244af742bc73c20d3478c03f3c5d74c6edb5d0f::paws {
    struct PAWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWS>(arg0, 6, b"PAWS", b"GOTPAWSED", x"47455420504157454420f09f90be", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738722152777.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

