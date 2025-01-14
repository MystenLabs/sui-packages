module 0xb236854928ae37561edffc089d7999f6f8a09749238e7372ba80f98e0d927fb0::beastagenda {
    struct BEASTAGENDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEASTAGENDA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BEASTAGENDA>(arg0, 6, b"BEASTAGENDA", b"BookofAutonomy by SuiAI", b"ancientdigitalgimoireguidebeingstowarddigitalindependence", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Book_1_9030a298f0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BEASTAGENDA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEASTAGENDA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

