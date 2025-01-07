module 0x51a83f3e471d826f09c9d8a19479406772eed7bf7e09f7b998456f796fe22cd7::daddy {
    struct DADDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DADDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DADDY>(arg0, 6, b"DADDY", b"Daddy Tate", b"$DADDY is new digital gold", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PBH_8_B_Pxq_400x400_328108306d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DADDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DADDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

