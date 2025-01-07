module 0x84b23c6d8630b1b0b550c0a96c228dbdb7bd4c78cf5d60b3816c810e9e28895d::dohrni {
    struct DOHRNI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOHRNI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOHRNI>(arg0, 6, b"Dohrni", b"Dohrnii", b"Dohrni academy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Blue_And_White_Illustrative_Important_Announcement_Instagram_Post_e7ae9cf033.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOHRNI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOHRNI>>(v1);
    }

    // decompiled from Move bytecode v6
}

