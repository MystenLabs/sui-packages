module 0x5c140c76c3edd69186edd21f4316a06b1fbd8317ffd507f9e2c2dba7ba050f7d::starket {
    struct STARKET has drop {
        dummy_field: bool,
    }

    fun init(arg0: STARKET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STARKET>(arg0, 6, b"STARKET", b"STAR KET", x"53544152204b4554202024535441524b45540a0a486d6d2e2e2e4d617962652077652063616e206361746368207468652072656420646f74207573696e6720612070686173652d6d6f64756c617465642074616368796f6e206265616d2e2e2e0a576f20666c79206f7665722042494c4c494f4e53206f6e20535549202d20746865206f6e6c79207265616c20636174206f6e2053544152204b455420756e6976657273736521204a6f696e20757321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/STAR_KET_77ad1348a2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STARKET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STARKET>>(v1);
    }

    // decompiled from Move bytecode v6
}

