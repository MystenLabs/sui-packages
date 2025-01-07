module 0x6b657c5f7abea6152312517f91c8bd888ab6b1c51afed0ae63dc944ae2507746::suikemonx {
    struct SUIKEMONX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKEMONX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKEMONX>(arg0, 6, b"SuikemonX", b"Suikemon", b"Suikemon is a concept for a cryptocurrency or token likely inspired by collectible creatures, similar to the popular Pokmon series. It is envisioned as a digital ecosystem, potentially combining elements of gaming, NFTs, and blockchain technology. The core idea involves creating unique creatures (Suikemons) that can be traded, upgraded, and used in various applications such as play-to-earn games or as NFTs. Users could collect and battle these digital creatures, participating in a decentralized marketplace where tokens are used for transactions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2_adffbc1e99.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKEMONX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKEMONX>>(v1);
    }

    // decompiled from Move bytecode v6
}

