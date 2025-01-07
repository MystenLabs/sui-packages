module 0x62bd14ccb81322b8526570bcf9a182e3b6caf0d2691afe9e25477c0580b4522::r7sui {
    struct R7SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: R7SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<R7SUI>(arg0, 6, b"R7SUI", b"RONALDOSUI", b"SUUUUUUUUII", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xe152cf4590affa8e187f98a4d31bba396e7922ae45c2c7c59b4575742dfde196_sui_sui_852ab28c69.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<R7SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<R7SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

