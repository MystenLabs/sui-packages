module 0xb30881b72734e3245b90c1c460b774fd0e93e99b736136fd88912013c76efbe::snek {
    struct SNEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNEK>(arg0, 6, b"SNEK", b"SUI SNEK", x"0a4c6f6f6b73206c696b6520796f757220686176696e672074726164696e672070726f626c656d7373732c206c6574206d652074616b652061206c6f6f6b7373732e204d6565742024736e656b2077696c6c2068656c70206f7574207769746820746865206d61726b6574737373732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_04_22_53_51_09d88da68a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNEK>>(v1);
    }

    // decompiled from Move bytecode v6
}

