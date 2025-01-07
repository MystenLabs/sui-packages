module 0x8462c4e7093d258c5f7a12def6ae44b95de8ba2f105412c3497c8b0c18d4febd::hopper {
    struct HOPPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPPER>(arg0, 6, b"HOPPER", b"The Rabbit", b"Hopper the rabbit from Moon, bouncing high to a cosmic tune!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmZ6rdWkRLMFGzceL6YtgabAVo3c33BkxrKWThoQX3necS")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<HOPPER>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<HOPPER>(14290069987311248191, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

