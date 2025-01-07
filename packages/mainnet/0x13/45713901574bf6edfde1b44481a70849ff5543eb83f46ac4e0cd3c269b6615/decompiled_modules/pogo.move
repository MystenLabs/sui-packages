module 0x1345713901574bf6edfde1b44481a70849ff5543eb83f46ac4e0cd3c269b6615::pogo {
    struct POGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: POGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POGO>(arg0, 9, b"POGO", b"SUI POGO", b"THE ONLY SUI POGO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POGO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POGO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

