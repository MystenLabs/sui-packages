module 0x4f0f7e20477409b8f8f03fae3b0716353db0520823707f78472130c064526fd9::suinatra {
    struct SUINATRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINATRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINATRA>(arg0, 6, b"Suinatra", b"FlyMeToTheMoon", b"The first Frank Sinatra meme on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Preview_2_bdd12c4855.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINATRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINATRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

