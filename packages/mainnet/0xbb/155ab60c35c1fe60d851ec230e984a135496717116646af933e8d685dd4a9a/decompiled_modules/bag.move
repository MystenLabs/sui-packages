module 0xbb155ab60c35c1fe60d851ec230e984a135496717116646af933e8d685dd4a9a::bag {
    struct BAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAG>(arg0, 9, b"BAG", b"FORTUNE", b"** Claim your Fortune **", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://munchlax.nl/tosti/geld-zak.gif")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BAG>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAG>>(v2, @0x644d71faacdaf3a15d50734dfc51d731209029ad296242305fea922d04cca4e0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

