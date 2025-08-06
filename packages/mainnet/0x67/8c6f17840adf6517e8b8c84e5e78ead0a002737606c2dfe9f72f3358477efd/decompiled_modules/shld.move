module 0x678c6f17840adf6517e8b8c84e5e78ead0a002737606c2dfe9f72f3358477efd::shld {
    struct SHLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHLD>(arg0, 6, b"SHLD", b"SuiShield", b"SuiShield es un token construido sobre la red SUI con enfoque en comunidad, crecimiento justo y liquidez automatizada. Con sistema de comisiones reinvertidas, staking y airdrops, busca fortalecer el ecosistema descentralizado.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1754472534545.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHLD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHLD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

