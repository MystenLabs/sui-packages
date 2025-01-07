module 0x25c3cc55fb5509a459e5a0d46efdc6e1fff6e8b3e9ab9099c991d0f5e1625374::suki {
    struct SUKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUKI>(arg0, 6, b"SUKI", b"SUKI INU", b"SUKI, the beloved Shiba Inu who sparked the viral Doge and Shiba Inu coins. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suki_50b8107366.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

