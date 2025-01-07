module 0x21c3c6125675e06558faec6b014571d2c51366817c934b55e37db70f3194c896::unicorn {
    struct UNICORN has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNICORN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNICORN>(arg0, 6, b"Unicorn", b"Unicorn on sui", b"Unicorn just landed! Welcome to the Unicorn Meme Coin family. Let's adventure together and discover surprises!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_04b0deca6c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNICORN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNICORN>>(v1);
    }

    // decompiled from Move bytecode v6
}

