module 0x66105090960de15dd0180cac8a0d2b36ce93701df516311d7d1b32ca9acbf017::squirt {
    struct SQUIRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIRT>(arg0, 6, b"SQUIRT", b"Squirt The Squid", b"Squirt Is A Very Curious Squid.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003610_23eb250f8e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIRT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUIRT>>(v1);
    }

    // decompiled from Move bytecode v6
}

