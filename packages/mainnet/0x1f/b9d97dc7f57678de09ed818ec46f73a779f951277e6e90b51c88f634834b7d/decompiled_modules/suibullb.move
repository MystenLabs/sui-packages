module 0x1fb9d97dc7f57678de09ed818ec46f73a779f951277e6e90b51c88f634834b7d::suibullb {
    struct SUIBULLB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBULLB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBULLB>(arg0, 6, b"SUIBULLB", b"sui bullss", b"THE MOST BULLISH BULL ON THE SUI BLOCKCHAIN!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_11_210905660_255da556b5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBULLB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBULLB>>(v1);
    }

    // decompiled from Move bytecode v6
}

