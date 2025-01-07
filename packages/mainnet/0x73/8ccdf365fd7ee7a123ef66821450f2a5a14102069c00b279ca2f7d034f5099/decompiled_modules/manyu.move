module 0x738ccdf365fd7ee7a123ef66821450f2a5a14102069c00b279ca2f7d034f5099::manyu {
    struct MANYU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANYU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANYU>(arg0, 6, b"MANYU", b"MANYU DOG SUI", x"43656c6562726174696e67207468652063757465737420536869626120707570200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CS_7_Lmjtuug_EU_Wt_Fgfyto79nrks_Kigv7_Fdcp9q_Puigd_Ls_15f9e37a55.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANYU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MANYU>>(v1);
    }

    // decompiled from Move bytecode v6
}

