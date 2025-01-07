module 0xdc3741274aa6ac72e319d3993e02355d0a9b3652dc1db1c138553508496a08f0::carm {
    struct CARM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CARM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CARM>(arg0, 6, b"CARM", b"CHILLY ARMADILLO", b"Cool, tough, and rolling through the meme charts. Chilly Armadillo is ice-cold gains.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_19_044918422_b4e614df84.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CARM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CARM>>(v1);
    }

    // decompiled from Move bytecode v6
}

