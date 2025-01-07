module 0xe42fda8231aa204042a74b6b471cb2695dbd6bfe57854087ac5fe135286cb57c::suiale {
    struct SUIALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIALE>(arg0, 6, b"SUIALE", b"suiWhale", b"sui whalees", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_08_00_09_34_3052aa8cf8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIALE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIALE>>(v1);
    }

    // decompiled from Move bytecode v6
}

