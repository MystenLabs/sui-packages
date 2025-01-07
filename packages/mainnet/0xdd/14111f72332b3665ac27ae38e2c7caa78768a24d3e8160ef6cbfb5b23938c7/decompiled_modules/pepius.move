module 0xdd14111f72332b3665ac27ae38e2c7caa78768a24d3e8160ef6cbfb5b23938c7::pepius {
    struct PEPIUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPIUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPIUS>(arg0, 9, b"PEPIUS", b"Pepius Maximus", b"Pepius Maximus, the meme gladiator and protector of chads.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0xba2867047bf7e36214a9fb95908f9bfd20c3b322.png?size=xl&key=44cb83")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PEPIUS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPIUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPIUS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

