module 0xf3c3ed385deeb1cdc292bd11cdb70c10783deaab9f965677e518d15bf7de437e::freedom {
    struct FREEDOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FREEDOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FREEDOM>(arg0, 6, b"Freedom", b"CZ", b"youre not prepared for whats coming", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0423_3188ff73db.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FREEDOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FREEDOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

