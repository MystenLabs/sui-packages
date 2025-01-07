module 0xac65752df5be458efee65567533d8a845debd939e2cffa63fdcd9d620fb6c427::perry {
    struct PERRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PERRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PERRY>(arg0, 6, b"PERRY", b"PERRY PLATIPUS", b"Perry is a blue-teal platypus with yellow tinged tangerine webbing only on his back feet (odd traits that platypuses outside of Danville don't have)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/29676_C35_3_B81_426_D_AD_45_46716360692_A_6cd073e753.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PERRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PERRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

