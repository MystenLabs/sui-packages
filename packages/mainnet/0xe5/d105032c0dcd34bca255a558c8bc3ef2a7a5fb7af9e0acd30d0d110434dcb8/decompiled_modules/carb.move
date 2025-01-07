module 0xe5d105032c0dcd34bca255a558c8bc3ef2a7a5fb7af9e0acd30d0d110434dcb8::carb {
    struct CARB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CARB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CARB>(arg0, 6, b"CARB", b"Carb On Sui", b"https://youtu.be/0QaAKi0NFkA?si=1p1LQePdyXJ8dygW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/artworks_000469617318_i032gv_t500x500_c3a4dc5feb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CARB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CARB>>(v1);
    }

    // decompiled from Move bytecode v6
}

