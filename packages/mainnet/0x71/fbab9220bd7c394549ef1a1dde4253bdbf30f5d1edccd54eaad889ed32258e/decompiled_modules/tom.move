module 0x71fbab9220bd7c394549ef1a1dde4253bdbf30f5d1edccd54eaad889ed32258e::tom {
    struct TOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"befad19b1c25a0f74b5c94bc7e97457d2dd03cc3e2f74ff9eb60fecc961eb719                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TOM>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TOM         ")))), trim_right(b"Tom's Odyssey                   "), trim_right(b"Tom's Odyssey has begun! The most insane 24/7 stream across Europe kicks off in London, and YOU control where we go next. Every penny goes back into the journey, meeting icons like Andrew Tate, hitting up Ibiza's final boss, and connecting with legends along the way. With top-tier tech fueling this adventure, you wont "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOM>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOM>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        let v1 = &v0;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != v1) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

