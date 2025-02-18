module 0x25ffe4f4d471ec693d0f6a643334312e883a767dd93d80519bd52ddaa653120d::killer {
    struct KILLER has drop {
        dummy_field: bool,
    }

    fun init(arg0: KILLER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KILLER>(arg0, 9, b"KILLER", b"Killer Whale Agent", b"Full-time market predator, part-time bottom feeder.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifqwr4kjs5iwfkhoamwll7hlqg3xtavyaza25hf3ttnmyz2jhodsm")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KILLER>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KILLER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KILLER>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

