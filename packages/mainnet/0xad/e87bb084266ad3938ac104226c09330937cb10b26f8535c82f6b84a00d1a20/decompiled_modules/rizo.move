module 0xade87bb084266ad3938ac104226c09330937cb10b26f8535c82f6b84a00d1a20::rizo {
    struct RIZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIZO>(arg0, 6, b"RIZO", b"Hahayes", b"Move over dogs, the era of the hedgehog has arrived! Meet Rizo, Elons favorite hedgehog.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/l73_D_Vvml_400x400_2083d3607f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIZO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIZO>>(v1);
    }

    // decompiled from Move bytecode v6
}

