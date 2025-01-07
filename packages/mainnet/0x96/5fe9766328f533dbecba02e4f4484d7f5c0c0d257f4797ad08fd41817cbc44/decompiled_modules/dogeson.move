module 0x965fe9766328f533dbecba02e4f4484d7f5c0c0d257f4797ad08fd41817cbc44::dogeson {
    struct DOGESON has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGESON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGESON>(arg0, 9, b"DOGESON", b"Dogeson", b"Dogeson meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x0e228376e458a66da1ff2428ef2ef8fe4c31783d.png?size=xl&key=7224f3")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOGESON>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGESON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGESON>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

