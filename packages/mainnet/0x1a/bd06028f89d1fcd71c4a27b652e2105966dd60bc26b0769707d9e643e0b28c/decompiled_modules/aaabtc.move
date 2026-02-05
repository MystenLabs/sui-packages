module 0x1abd06028f89d1fcd71c4a27b652e2105966dd60bc26b0769707d9e643e0b28c::aaabtc {
    struct AAABTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAABTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAABTC>(arg0, 9, b"AAABTC", b"AAA Bitcoin", b"Chain-Agnostic Bitcoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://greenfield-sp.defibit.io/view/aaa/BTC.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AAABTC>(&mut v2, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AAABTC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAABTC>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

