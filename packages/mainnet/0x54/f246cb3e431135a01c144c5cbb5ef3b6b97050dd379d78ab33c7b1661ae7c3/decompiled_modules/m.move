module 0x54f246cb3e431135a01c144c5cbb5ef3b6b97050dd379d78ab33c7b1661ae7c3::m {
    struct M has drop {
        dummy_field: bool,
    }

    fun init(arg0: M, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<M>(arg0, 6, b"M", b"Murad", b"The king of Meme coin world and The Real Alpha", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/C46_A7882_DF_19_48_BC_B58_E_4_A7871172659_feb32b8b05.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<M>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<M>>(v1);
    }

    // decompiled from Move bytecode v6
}

