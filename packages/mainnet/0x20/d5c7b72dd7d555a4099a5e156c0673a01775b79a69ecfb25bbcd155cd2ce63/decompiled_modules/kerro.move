module 0x20d5c7b72dd7d555a4099a5e156c0673a01775b79a69ecfb25bbcd155cd2ce63::kerro {
    struct KERRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KERRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KERRO>(arg0, 6, b"KERRO", b"Kerropi Sui", b"Meet Kerropi, the amphibious adventurer with a smile as big as his leaps! With a hop in his step and a twinkle in his eye, Kerropi is the master of fun and frolic in the pond. [ Telegram :  Yes] [ Twitter :  Yes] [ Website :  Yes]", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_08a6735fc0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KERRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KERRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

