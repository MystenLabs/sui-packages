module 0xa6e54f43b662d966d188d61dd545c65a233a7443389f45e01269996707b4e555::poch {
    struct POCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: POCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POCH>(arg0, 6, b"POCH", b"POCHITA", b"Can we fight ponch solana", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GY_5a7_O9b_MA_Aao49_c304a6d21a.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

