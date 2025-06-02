module 0x68c62f5b4bb8a09e288275285c59c771a683700c21c9a4e0cccc01c29e76b56b::adeli {
    struct ADELI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADELI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADELI>(arg0, 6, b"ADELI", b"Adeniyi's Deli", b"Adeniyi's Degen Deli Delight. Degen's unite.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1748896619649.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADELI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADELI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

