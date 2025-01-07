module 0x58f8fae851af7828eaf5d733c68ed478196604ba92b702987c96325efd4364c3::fart {
    struct FART has drop {
        dummy_field: bool,
    }

    fun init(arg0: FART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FART>(arg0, 6, b"FART", b"FartCoin", b"The stinkiest crypto currency on the SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fartcoin_d0e062e901.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FART>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FART>>(v1);
    }

    // decompiled from Move bytecode v6
}

