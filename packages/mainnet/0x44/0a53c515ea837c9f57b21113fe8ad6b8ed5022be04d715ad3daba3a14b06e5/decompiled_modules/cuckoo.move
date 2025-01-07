module 0x440a53c515ea837c9f57b21113fe8ad6b8ed5022be04d715ad3daba3a14b06e5::cuckoo {
    struct CUCKOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUCKOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUCKOO>(arg0, 6, b"CUCKOO", b"Cute cuckoo", b"Cuckoos are friends of human beings. We should all love birds.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730467059835.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CUCKOO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUCKOO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

