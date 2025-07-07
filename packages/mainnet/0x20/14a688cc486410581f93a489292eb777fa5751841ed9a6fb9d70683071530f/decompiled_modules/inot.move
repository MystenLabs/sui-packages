module 0x2014a688cc486410581f93a489292eb777fa5751841ed9a6fb9d70683071530f::inot {
    struct INOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INOT>(arg0, 6, b"INOT", b"Is NOT", x"4953204e4f54202824494e4f5429205468652050617261646f7820506f7765726564204d656d6520546f6b656e200a57686174206974206973206e6f742e2e2e69732065786163746c7920776861742069742069732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibe3zociqt6ezxxptqv53hjbn2il4dnisgyaz77gfzz7q7c2crp3m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<INOT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

