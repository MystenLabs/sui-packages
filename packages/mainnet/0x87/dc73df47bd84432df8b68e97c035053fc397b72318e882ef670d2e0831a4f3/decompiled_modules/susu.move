module 0x87dc73df47bd84432df8b68e97c035053fc397b72318e882ef670d2e0831a4f3::susu {
    struct SUSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUSU>(arg0, 6, b"SUSU", b"susu", b"susu for", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6a06fe9f70d5dc2ce1d799f77729f616_bd8a8ea64b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

