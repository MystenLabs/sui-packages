module 0x2f17a17c6c71ac8a02887f368e206ce1326a98e3e91884b18bc0200f5ff7d67f::bnu {
    struct BNU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BNU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BNU>(arg0, 6, b"BNU", b"BLUB INU", b"Dive into the fun with BLUB INU, the latest meme coin sensation on the SUI blockchain! With its vibrant blue doggy mascot, BLUB INU combines playful charm with cutting-edge technology. Whether you're a crypto enthusiast or just in it for the laughs, BLUB INU is here to bring a splash of excitement to your portfolio.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BLUB_INU_dff5c02cf6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BNU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BNU>>(v1);
    }

    // decompiled from Move bytecode v6
}

