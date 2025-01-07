module 0xcaaac0ab5f9cb2ad0d59083c5ac5cb6bf97bb6f6a2094ef41cdd2496f57b0c04::wz {
    struct WZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: WZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WZ>(arg0, 6, b"WZ", b"wangzai", b"wangzai milk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0e02459cb9cd18439153337ed9f52a77_dafb0fdef3.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

