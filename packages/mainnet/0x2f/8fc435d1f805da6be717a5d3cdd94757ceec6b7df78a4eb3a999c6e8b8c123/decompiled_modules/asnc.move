module 0x2f8fc435d1f805da6be717a5d3cdd94757ceec6b7df78a4eb3a999c6e8b8c123::asnc {
    struct ASNC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASNC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASNC>(arg0, 9, b"ASNC", b"ASSNCREED", b"ASSASSINS CREED FANS HERE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b14fb110-0ca8-4b86-94c7-9fa2d15d5948.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASNC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASNC>>(v1);
    }

    // decompiled from Move bytecode v6
}

