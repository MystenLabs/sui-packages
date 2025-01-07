module 0xbd9712805303803caf948b1e7b369ed0390f1542579c626716952b10552eb67f::monkfish {
    struct MONKFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONKFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONKFISH>(arg0, 6, b"MONKFISH", b"MONK FISH", x"244d4f4e4b46495348207468652073706f6f6b7920666973682066726f6d20537569206f6365616e2e0a68747470733a2f2f742e6d652f4d6f6e6b737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3733_8c119fecb9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONKFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONKFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

