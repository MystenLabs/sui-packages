module 0x83ae025b77fde3df33e2d5906ef10f14114bca60048dfa2d6c10f6b8d73cd324::orax {
    struct ORAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORAX>(arg0, 6, b"Orax", b"Oracle", b"An etheral AI that evaluates crypto projects by analyzing expert insights and trends on X", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735728763947.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ORAX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORAX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

