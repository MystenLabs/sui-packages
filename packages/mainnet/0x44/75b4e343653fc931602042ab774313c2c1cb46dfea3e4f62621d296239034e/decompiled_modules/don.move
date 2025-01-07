module 0x4475b4e343653fc931602042ab774313c2c1cb46dfea3e4f62621d296239034e::don {
    struct DON has drop {
        dummy_field: bool,
    }

    fun init(arg0: DON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DON>(arg0, 6, b"DON", b"DON Panda", b"In the dark underbelly of the Sui blockchain, power doesnt come to the weakits seized by the ruthless. And no one holds more power than DON, the savage panda kingpin who runs the infamous Sui Triad. He's a trench legend. Join The Triad Today.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000113639_70301a7f01.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DON>>(v1);
    }

    // decompiled from Move bytecode v6
}

