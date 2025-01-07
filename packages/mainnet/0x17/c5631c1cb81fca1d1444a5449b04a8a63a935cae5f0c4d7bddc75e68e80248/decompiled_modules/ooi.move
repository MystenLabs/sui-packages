module 0x17c5631c1cb81fca1d1444a5449b04a8a63a935cae5f0c4d7bddc75e68e80248::ooi {
    struct OOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OOI>(arg0, 9, b"ooi", b"ooioi cat", b"ooooioi cat, sol, oooioi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/HHr3avYJN1n8rjGDNSWA1uKd2FuTpFJUhBMHgLspump.png?size=xl&key=577793")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OOI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OOI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OOI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

