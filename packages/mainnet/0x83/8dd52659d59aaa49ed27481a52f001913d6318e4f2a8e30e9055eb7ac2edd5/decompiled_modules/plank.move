module 0x838dd52659d59aaa49ed27481a52f001913d6318e4f2a8e30e9055eb7ac2edd5::plank {
    struct PLANK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLANK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLANK>(arg0, 6, b"PLANK", b"Plankton", b"$PLANK is the tiny mastermind of crypto! Inspired by the relentless Plankton, this token may be small, but its packed with big plans to disrupt the market. Join the $PLANK army, where small fries dream big and nothing is out of reach!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/avatars_000414155112_310olt_t1080x1080_67d41e279e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLANK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLANK>>(v1);
    }

    // decompiled from Move bytecode v6
}

