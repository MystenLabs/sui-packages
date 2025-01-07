module 0x285cd31c33a936e9408e1baae7e5d1b9edabcbcc7e9c6bab76472cdc8bdd4b97::ofo {
    struct OFO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OFO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OFO>(arg0, 6, b"OFO", b"DogFuckHop", b"dogfuckhop.MOVE IS THE BEST.FUCK HOP FUCK HOP.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8191f0d90bf6b16f07f93d231344e20_fdebb788d6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OFO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OFO>>(v1);
    }

    // decompiled from Move bytecode v6
}

