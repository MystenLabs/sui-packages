module 0xb8f5c94e4a4998b64685d0722c735d27d947f87493a5077a11d9a9194d3c0b63::crush {
    struct CRUSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRUSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRUSH>(arg0, 6, b"CRUSH", b"Scam Crusher", b"The official utility token for Scam Crusher Protocol on Sui. Fueling the destruction of scam NFTs. Burn to evolve, hold to earn. Powered by Walrus.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0459_bc807044d0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRUSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRUSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

