module 0xe9362659504557639d23c89bbebba912350d975d31b6096344f48352fa56ba65::b_paw {
    struct B_PAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_PAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_PAW>(arg0, 9, b"bPAW", b"bToken PAW", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_PAW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_PAW>>(v1);
    }

    // decompiled from Move bytecode v6
}

