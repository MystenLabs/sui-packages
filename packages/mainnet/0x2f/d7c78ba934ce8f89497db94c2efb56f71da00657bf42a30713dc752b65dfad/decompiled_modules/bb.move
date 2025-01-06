module 0x2fd7c78ba934ce8f89497db94c2efb56f71da00657bf42a30713dc752b65dfad::bb {
    struct BB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BB>(arg0, 6, b"BB", b"Banana bird ", b"Banana bird landing at Turbofun...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736198979531.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

