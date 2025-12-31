module 0x8c34cee4c932ffb98c8c9299f8ac43cb6e4cd3f770a5f014a17473c1b5c86207::suis {
    struct SUIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIS>(arg0, 6, b"SUIS", b"SUI Siren", b"May this SUI siren bring joy to every owner! Happy New Year 2026 to the entire community!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logosjpg_83e79f134b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

