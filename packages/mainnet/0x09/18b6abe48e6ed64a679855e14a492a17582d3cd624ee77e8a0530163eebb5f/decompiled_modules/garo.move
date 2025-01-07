module 0x918b6abe48e6ed64a679855e14a492a17582d3cd624ee77e8a0530163eebb5f::garo {
    struct GARO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GARO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GARO>(arg0, 6, b"GARO", b"GaroDog Sui", b"$GARO, the rising star in the meme coin universe on  brings a playful twist with its dog-themed charm. Embrace the whimsical world of GARO, where crypto meets humor, and join the journey toward the next big meme coin sensation", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001156_ecdcfe88b3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GARO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GARO>>(v1);
    }

    // decompiled from Move bytecode v6
}

