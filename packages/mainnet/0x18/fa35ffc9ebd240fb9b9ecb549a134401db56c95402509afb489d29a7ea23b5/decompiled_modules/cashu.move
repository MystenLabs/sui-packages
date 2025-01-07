module 0x18fa35ffc9ebd240fb9b9ecb549a134401db56c95402509afb489d29a7ea23b5::cashu {
    struct CASHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CASHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CASHU>(arg0, 6, b"Cashu", b"CashuBTC", b"Open-source Chaumian Ecash protocol for Bitcoin Learn more at cashu.space Support our mission at opencash.dev", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736048924244.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CASHU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CASHU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

