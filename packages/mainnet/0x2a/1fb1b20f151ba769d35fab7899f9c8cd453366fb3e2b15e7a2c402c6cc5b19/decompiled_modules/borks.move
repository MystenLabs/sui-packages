module 0x2a1fb1b20f151ba769d35fab7899f9c8cd453366fb3e2b15e7a2c402c6cc5b19::borks {
    struct BORKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BORKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BORKS>(arg0, 6, b"BORKS", b"BORK FUN", b"Dexscreener Paid.Check now  on our website: https://www.borkonsui.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_2_3_bf39494416.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BORKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BORKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

