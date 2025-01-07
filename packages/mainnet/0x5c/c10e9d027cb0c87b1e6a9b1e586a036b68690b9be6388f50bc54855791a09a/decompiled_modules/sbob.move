module 0x5cc10e9d027cb0c87b1e6a9b1e586a036b68690b9be6388f50bc54855791a09a::sbob {
    struct SBOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBOB>(arg0, 6, b"SBOB", b"SPONGE BOB", b"Sponge Bob comes to realize the mission of becoming the most known and used cryptocurrency on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_a0ab2312c9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

