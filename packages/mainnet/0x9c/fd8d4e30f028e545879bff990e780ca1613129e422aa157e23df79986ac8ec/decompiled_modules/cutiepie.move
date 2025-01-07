module 0x9cfd8d4e30f028e545879bff990e780ca1613129e422aa157e23df79986ac8ec::cutiepie {
    struct CUTIEPIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUTIEPIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUTIEPIE>(arg0, 6, b"Cutiepie", b"Cutie", b"Cutest cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732221780809.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CUTIEPIE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUTIEPIE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

