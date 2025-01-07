module 0xca3ab3b68d8c9dbdce1bb1b428b9357ba5b0289e20f70f46d603687c746cd5e8::sfood {
    struct SFOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFOOD>(arg0, 6, b"SFOOD", b"SUI FOOD", b"$SUIFOOD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Ziv2_Cla_AA_Efe3w_8d59863833.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFOOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFOOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

