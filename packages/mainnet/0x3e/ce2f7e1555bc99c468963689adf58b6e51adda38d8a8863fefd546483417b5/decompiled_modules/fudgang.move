module 0x3ece2f7e1555bc99c468963689adf58b6e51adda38d8a8863fefd546483417b5::fudgang {
    struct FUDGANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUDGANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUDGANG>(arg0, 6, b"FUDGANG", b"Fuddies Gang", b"AI NFT Collection & Meme coin on $SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735755469702.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUDGANG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUDGANG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

