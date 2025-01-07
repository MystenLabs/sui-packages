module 0x5e1ca3c6f32cb31708880c6883853650d5475b05ec9777f138c67230e35d7361::lmpast {
    struct LMPAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: LMPAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LMPAST>(arg0, 6, b"Lmpast", b"lampastyk", b"xax", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/54_cf2098b262.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LMPAST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LMPAST>>(v1);
    }

    // decompiled from Move bytecode v6
}

