module 0xef214bf3da0478d240560db7038f16ace0bede8577f548efc0514b23f62e9130::simp {
    struct SIMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIMP>(arg0, 6, b"SIMP", b"SonicInuMarvelPornHub", b"simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp simp ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_05_05_18_52_17_5437e2cc67.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

