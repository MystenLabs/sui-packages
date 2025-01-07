module 0xdee24890d15fbdb6f0ce3d18af465980bb69c17a778161ced782b0659066f8e6::mnky {
    struct MNKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MNKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MNKY>(arg0, 6, b"MNKY", b"MOON MONKEY", x"4d4e4b592e2054686520426c756520417374726f6e617574204d6f6e6b6579206f6e2061204d697373696f6e20746f20746865204d6f6f6e21200a47657420726561647920666f7220612077696c642072696465207468726f7567682074686520636f736d6f732077697468204d6f6f6e6b65792c20746865206d656d6520746f6b656e20746861742773206f7574206f66207468697320776f726c64210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MOON_MONKEY_290c6b7759.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MNKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

