module 0xa6743f63dae197f9bcd7180918b8692f877654a76547f256b9173dd40ef0a6dd::smusk {
    struct SMUSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMUSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMUSK>(arg0, 6, b"SMUSK", b"Stoned Musk", b"Since the day of this famous blunt, Elon sometimes burns a spliff in the evening and buys crypto when he is high. Let's push the StonedMusk to the moon, Elon will blow it to MARS.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ppp_318e0db843.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMUSK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMUSK>>(v1);
    }

    // decompiled from Move bytecode v6
}

