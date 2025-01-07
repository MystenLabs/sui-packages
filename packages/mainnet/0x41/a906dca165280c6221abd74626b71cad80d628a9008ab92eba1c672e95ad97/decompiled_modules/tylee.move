module 0x41a906dca165280c6221abd74626b71cad80d628a9008ab92eba1c672e95ad97::tylee {
    struct TYLEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TYLEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TYLEE>(arg0, 6, b"TYLEE", b"Tylee on SUI", x"54796c6565206f6e20535549202e2e2e20474d452043454f205279616e20436f68656e27732054656163757020506f6f646c650a0a746865206865616462616e64207374617973206f6e2120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/l_MYODY_6_O_400x400_7df7e3a265.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TYLEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TYLEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

