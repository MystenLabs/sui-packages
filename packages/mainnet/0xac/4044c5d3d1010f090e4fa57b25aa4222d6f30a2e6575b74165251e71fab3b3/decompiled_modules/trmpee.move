module 0xac4044c5d3d1010f090e4fa57b25aa4222d6f30a2e6575b74165251e71fab3b3::trmpee {
    struct TRMPEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRMPEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRMPEE>(arg0, 6, b"TRMPEE", b"TRUMPEE ON SUI", b"TRMPEE \"MAKE MEMECOINS GREAT AGAIN!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/peptr_e9ad940ab2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRMPEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRMPEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

