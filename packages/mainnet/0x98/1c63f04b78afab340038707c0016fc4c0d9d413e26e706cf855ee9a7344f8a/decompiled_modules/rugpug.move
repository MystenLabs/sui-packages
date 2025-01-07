module 0x981c63f04b78afab340038707c0016fc4c0d9d413e26e706cf855ee9a7344f8a::rugpug {
    struct RUGPUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUGPUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUGPUG>(arg0, 6, b"RUGPUG", b"RUGPUG on SUI", b"$RUGPUG : A project that looks like one thing, but delivers something entirely different. The pug's got the rug do you have the guts? ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8_Nqv_Rm_D_400x400_de3e00e8de.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUGPUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUGPUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

