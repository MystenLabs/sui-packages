module 0xc9e20bb949eb6a5a94ff98c2b83834bc072746a031b4f2984c3ed2aa3da1f1e::suicum {
    struct SUICUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICUM>(arg0, 6, b"SUICUM", b"SuiCumRocket", b"Cumrocket is that one in a million swimmer that makes it all the way! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cum_Rocket_28ce7fb4e6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

