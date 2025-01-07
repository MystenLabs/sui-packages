module 0x6b0cdfe552921f23a0c8842010cc27b8116cd4995de5478b0f652bf6561a1fbe::belugabloop {
    struct BELUGABLOOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BELUGABLOOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BELUGABLOOP>(arg0, 6, b"BELUGABLOOP", b"BLOOP BELUGA", b"Bloop emerges as a \"super-beluga whale,\" larger and stronger than the whales in the crypto world. With significant power and influence, Bloop is a token that captivates the community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4074_0236def88b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BELUGABLOOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BELUGABLOOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

