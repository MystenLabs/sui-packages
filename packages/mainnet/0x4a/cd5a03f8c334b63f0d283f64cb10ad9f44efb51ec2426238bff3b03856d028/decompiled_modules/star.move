module 0x4acd5a03f8c334b63f0d283f64cb10ad9f44efb51ec2426238bff3b03856d028::star {
    struct STAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: STAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STAR>(arg0, 6, b"STAR", b"Sui Star", b"Once upon a time, on a small island surrounded by the vast ocean, Tony Star and Sui Star lived as best friends. They spent their days playing under the coconut trees, laughing together as the waves gently touched the shore. They had been inseparable for as long as they could remember, two stars shining brightly in their little world. But deep inside, Sui Star harbored a dreama dream of becoming something bigger, something legendary.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gu98_H752_400x400_bb7651912b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

