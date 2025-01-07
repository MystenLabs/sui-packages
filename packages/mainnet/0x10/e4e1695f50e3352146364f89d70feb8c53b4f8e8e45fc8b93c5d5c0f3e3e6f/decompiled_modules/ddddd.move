module 0x10e4e1695f50e3352146364f89d70feb8c53b4f8e8e45fc8b93c5d5c0f3e3e6f::ddddd {
    struct DDDDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDDDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDDDD>(arg0, 6, b"DDDDD", b"AAAAA", b"Water that cannot drop because always Hop hop Hop hop Hop hop Hop hop Hop hop Hop hop Hop hop Hop hop Hop hop Hop hop Hop hop Hop hop Hop hop Hop hop Hop hop Hop hop Hop hop Hop hop ...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hippo_ea72756c19.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDDDD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DDDDD>>(v1);
    }

    // decompiled from Move bytecode v6
}

