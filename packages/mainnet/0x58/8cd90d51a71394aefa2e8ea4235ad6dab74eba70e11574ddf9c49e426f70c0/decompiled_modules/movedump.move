module 0x588cd90d51a71394aefa2e8ea4235ad6dab74eba70e11574ddf9c49e426f70c0::movedump {
    struct MOVEDUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVEDUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVEDUMP>(arg0, 6, b"MOVEDUMP", b"Movedump.com", b"99% of tokens on MovePump are trash. This one makes no promises, just aims to hit a DEX and chase that million dollar marketcap.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/movedump_688607b7ec.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVEDUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOVEDUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

