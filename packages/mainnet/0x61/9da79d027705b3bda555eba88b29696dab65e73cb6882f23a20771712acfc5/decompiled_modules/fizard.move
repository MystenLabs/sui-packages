module 0x619da79d027705b3bda555eba88b29696dab65e73cb6882f23a20771712acfc5::fizard {
    struct FIZARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIZARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIZARD>(arg0, 6, b"FIZARD", b"Sui Fizard", b"The $FIZARD combined with its sui web and sticky arms is coming to be a meme project.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000074080_1ef772a4d0.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIZARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIZARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

