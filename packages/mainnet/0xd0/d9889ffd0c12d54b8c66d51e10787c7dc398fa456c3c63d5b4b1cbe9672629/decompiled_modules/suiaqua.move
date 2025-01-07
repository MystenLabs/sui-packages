module 0xd0d9889ffd0c12d54b8c66d51e10787c7dc398fa456c3c63d5b4b1cbe9672629::suiaqua {
    struct SUIAQUA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIAQUA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIAQUA>(arg0, 6, b"SUIAQUA", b"Aqua Sui Lightyear", b"To Infinity And Beyond", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_6316750991302704569_x_8be24b9169.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIAQUA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIAQUA>>(v1);
    }

    // decompiled from Move bytecode v6
}

