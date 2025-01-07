module 0xf9ccad51142634f3c789979384108bdf1fe4474decaab303e924b218d8e66421::suick {
    struct SUICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICK>(arg0, 6, b"SUICK", b"Suick", b"You must be sick if you think Sui will make it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6140_340237ac8e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

