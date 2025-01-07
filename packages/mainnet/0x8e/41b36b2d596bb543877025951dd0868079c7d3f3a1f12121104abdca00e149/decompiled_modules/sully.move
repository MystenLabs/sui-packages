module 0x8e41b36b2d596bb543877025951dd0868079c7d3f3a1f12121104abdca00e149::sully {
    struct SULLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SULLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SULLY>(arg0, 6, b"SULLY", b"SullyTheShrimp", b" Meet the king of the sea. $SULLY on $SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sully_The_Shrimp_0d26f0d367.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SULLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SULLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

