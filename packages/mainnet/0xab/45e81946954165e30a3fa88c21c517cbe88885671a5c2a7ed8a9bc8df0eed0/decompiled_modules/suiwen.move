module 0xab45e81946954165e30a3fa88c21c517cbe88885671a5c2a7ed8a9bc8df0eed0::suiwen {
    struct SUIWEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWEN>(arg0, 6, b"SUIWEN", b"Wen Moon Sui", b"WEN on Suinetwork is A Meme Project Dedicated to community decentralization.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241015_124914_627_d4019e0a8e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

