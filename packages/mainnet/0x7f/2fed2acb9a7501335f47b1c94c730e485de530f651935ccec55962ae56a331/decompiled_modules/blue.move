module 0x7f2fed2acb9a7501335f47b1c94c730e485de530f651935ccec55962ae56a331::blue {
    struct BLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUE>(arg0, 9, b"AKANE", b"AKANE", b"BLUE is the native token of Bluefin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/7ipDvePMxS33q2fhw7njT9HL3sVa5p63UrGXrjoHpump.png?size=lg&key=32f07a")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<BLUE>>(0x2::coin::mint<BLUE>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BLUE>>(v2);
    }

    // decompiled from Move bytecode v6
}

