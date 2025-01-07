module 0xff187931098e4acf4e70330bfc11df7d77458a8c1d4b705cbf6fcd08fa16ba91::moob {
    struct MOOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOOB>(arg0, 6, b"MOOB", b"SUIMOOB", b"$MOOB is a simple meme that flies to the moon..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/h4z0xc_Q_400x400_ab981974db.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

