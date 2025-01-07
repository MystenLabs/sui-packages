module 0xe8c78e3ad7b82359b8edcfbc6ffd72da785cd5edab620d190186acfce6a26d02::bunny2 {
    struct BUNNY2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUNNY2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUNNY2>(arg0, 6, b"Bunny2", b"Bunny", b"Bunny11", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732163733833.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUNNY2>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUNNY2>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

