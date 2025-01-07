module 0x4734ebe2989504e71e6c6ff3c8700fc817474b8d7cc937520849012410dfcc85::suic {
    struct SUIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIC>(arg0, 6, b"SUIC", b"Sui Classic", b"A decentralized computing platform that runs smart contracts: applications that run exactly as programmed without downtime on SUI Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731899774831.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

