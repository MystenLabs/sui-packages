module 0x1a57b7c74527c65e7213447d6cd26d35d861b7346fbe4ec74e2ec55542022775::snek {
    struct SNEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNEK>(arg0, 6, b"SNEK", b"SNEK SUI", x"4c6f6f6b73206c696b6520796f757220686176696e672074726164696e672070726f626c656d7373732c206c6574206d652074616b652061206c6f6f6b7373732e204d6565742024736e656b2077696c6c2068656c70206f7574207769746820746865206d61726b6574737373732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3853_2d1c4d031d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNEK>>(v1);
    }

    // decompiled from Move bytecode v6
}

