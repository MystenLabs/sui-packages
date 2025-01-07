module 0x48732c91c5476e778869bb55122c24a12b66bf68c6b3d08442d74f0b4be6158c::nihon {
    struct NIHON has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIHON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIHON>(arg0, 6, b"NIHON", b"meme for Japan", b"First meme for a Country on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/big_white_175_07b70315e6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIHON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIHON>>(v1);
    }

    // decompiled from Move bytecode v6
}

