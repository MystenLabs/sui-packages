module 0x27e758e0cd89d40355602105ebed3217db6da7a318e1b4db54b984bedb1b855a::sog {
    struct SOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOG>(arg0, 6, b"SoG", b"Scooby-DOOG", b"Scooby-DOOG MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_08_557703de71.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

