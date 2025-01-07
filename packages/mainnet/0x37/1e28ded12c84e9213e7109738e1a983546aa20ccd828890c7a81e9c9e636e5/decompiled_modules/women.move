module 0x371e28ded12c84e9213e7109738e1a983546aa20ccd828890c7a81e9c9e636e5::women {
    struct WOMEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOMEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOMEN>(arg0, 6, b"WOMEN", b"Sui Women", b"Who run the world? WOMEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000593_b701daa362.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOMEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOMEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

