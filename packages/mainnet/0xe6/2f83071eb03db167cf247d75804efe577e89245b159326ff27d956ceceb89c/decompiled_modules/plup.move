module 0xe62f83071eb03db167cf247d75804efe577e89245b159326ff27d956ceceb89c::plup {
    struct PLUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLUP>(arg0, 6, b"PLUP", b"Suiplup", b"I'm SuiPlup the king of all Piplup,i will be the king of the sea with my Piplup's army ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/71e116cd_4e11_46b3_a41d_35b70be240a5_505aa42d11.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

