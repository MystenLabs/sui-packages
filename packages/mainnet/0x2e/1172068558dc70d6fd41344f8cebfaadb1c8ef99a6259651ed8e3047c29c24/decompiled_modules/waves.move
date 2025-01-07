module 0x2e1172068558dc70d6fd41344f8cebfaadb1c8ef99a6259651ed8e3047c29c24::waves {
    struct WAVES has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAVES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAVES>(arg0, 6, b"WAVES", b"Sui waves", x"57617665732073776f6f707320696e20616e64207475726e7320796f7520696e746f206120737572666572206f6e20746865207761766573206f66206368616f732e204c697665207769746820656e65726779206f7220686f6c64206f6e207469676874210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/wave_a428a235b8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAVES>>(v1);
    }

    // decompiled from Move bytecode v6
}

