module 0x44a9a173a187499d6bb89eef104bd40390a61d7e155c000fd8ac51c695009da3::mstr {
    struct MSTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSTR>(arg0, 6, b"MSTR", b"MSTR2100", b"$MSTR: The Crypto SUI Stock   *Not affiliated with the MicroStrategy Incorporated | https://t.me/MSTR2100Portal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/t_y_Hhf_Y_400x400_5a2973464b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MSTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

