module 0x3f002bed5f39980e39adff42210785a1863341a389bd55614a9ccc3b22ab274e::emrock {
    struct EMROCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMROCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMROCK>(arg0, 6, b"EMROCK", b"Excuse me rocks", b"We will shine with yellow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_10_224029_8387cb2130.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMROCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EMROCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

