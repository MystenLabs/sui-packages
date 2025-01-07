module 0xfd637b526ce7930efa193bac6d80e71d17ff7021b730a489bba3b26a95fb56e6::fuku {
    struct FUKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUKU>(arg0, 6, b"Fuku", b"Kufu", b"where the power of a tsunami meets the playful spirit of a surf-loving Shiba Inu. This isn't just another token; it's a tidal wave of innovation on the Sui Blockchain. Surfing through the crypto market with unparalleled speed and agility, $suidog represents the force of nature in the world of digital currency.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000022052_2f65951d02.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

