module 0xfae10c593f8c5e1b8a9c56fe0eef63c683413c9f48c47a0be0c6ae904449a1e7::hashsui {
    struct HASHSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HASHSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HASHSUI>(arg0, 6, b"HASHSUI", b"Hashsui", b"Hashshui live", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000028541_dc027ed9a5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HASHSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HASHSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

