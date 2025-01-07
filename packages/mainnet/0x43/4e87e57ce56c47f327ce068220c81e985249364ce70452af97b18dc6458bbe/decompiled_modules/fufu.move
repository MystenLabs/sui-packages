module 0x434e87e57ce56c47f327ce068220c81e985249364ce70452af97b18dc6458bbe::fufu {
    struct FUFU has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUFU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUFU>(arg0, 6, b"FUFU", b"FuFu", b"a $FUFU  sat alone on the beach, its gaze fixed on the horizon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zot2_Nzaw_A_Ax_H7w_a4e63de92e.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUFU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUFU>>(v1);
    }

    // decompiled from Move bytecode v6
}

