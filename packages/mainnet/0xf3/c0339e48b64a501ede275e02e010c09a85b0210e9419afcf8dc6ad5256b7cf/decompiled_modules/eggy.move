module 0xf3c0339e48b64a501ede275e02e010c09a85b0210e9419afcf8dc6ad5256b7cf::eggy {
    struct EGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGGY>(arg0, 6, b"EGGY", b"Eggy the pet egg", b"$EGGY, The Uncrackable. https://eggycoin.xyz/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_10_070813_a0590a92de.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

