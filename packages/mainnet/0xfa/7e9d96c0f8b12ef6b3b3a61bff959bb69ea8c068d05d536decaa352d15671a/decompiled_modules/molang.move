module 0xfa7e9d96c0f8b12ef6b3b3a61bff959bb69ea8c068d05d536decaa352d15671a::molang {
    struct MOLANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOLANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOLANG>(arg0, 9, b"MOLANG", b"Molang", b"Molang is an animated children's television series created by the animation studio Millimages.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/EsKE2kHLw3itXUKMiKWJxRsQj9zdhaYufG4qQU9ypump.png?size=lg&key=a3a66f")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOLANG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<MOLANG>>(0x2::coin::mint<MOLANG>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MOLANG>>(v2);
    }

    // decompiled from Move bytecode v6
}

