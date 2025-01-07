module 0x8ed77f1df2101c963d00bc634e768900c30606fbf8a42814367605024a9e1a55::smudge {
    struct SMUDGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMUDGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMUDGE>(arg0, 6, b"SMUDGE", b"SMUDGE CAT", b"SMUDGE CAT on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_04_21_02_27_17_fc97111129.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMUDGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMUDGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

