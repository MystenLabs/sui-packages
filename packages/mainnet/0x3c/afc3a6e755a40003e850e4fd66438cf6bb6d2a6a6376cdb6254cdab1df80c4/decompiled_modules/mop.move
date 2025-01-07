module 0x3cafc3a6e755a40003e850e4fd66438cf6bb6d2a6a6376cdb6254cdab1df80c4::mop {
    struct MOP has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MOP>, arg1: vector<0x2::coin::Coin<MOP>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<MOP>>(&mut arg1);
        0x2::pay::join_vec<MOP>(&mut v0, arg1);
        0x2::coin::burn<MOP>(arg0, 0x2::coin::split<MOP>(&mut v0, arg2, arg3));
        if (0x2::coin::value<MOP>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<MOP>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<MOP>(v0);
        };
    }

    fun init(arg0: MOP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b"https://em-content.zobj.net/source/microsoft/378/grinning-face-with-smiling-eyes_1f604.png"));
        let (v2, v3) = 0x2::coin::create_currency<MOP>(arg0, 6, b"MOP", b"MOP", b"MOP IS LITERALLY A MEME TOKEN.", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOP>>(v3);
        0x2::coin::mint_and_transfer<MOP>(&mut v4, 1000000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOP>>(v4, v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MOP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MOP>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<MOP>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MOP>>(arg0);
    }

    // decompiled from Move bytecode v6
}

