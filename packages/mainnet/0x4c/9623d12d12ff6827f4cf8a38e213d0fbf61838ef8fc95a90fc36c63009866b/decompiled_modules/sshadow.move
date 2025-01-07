module 0x4c9623d12d12ff6827f4cf8a38e213d0fbf61838ef8fc95a90fc36c63009866b::sshadow {
    struct SSHADOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSHADOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSHADOW>(arg0, 6, b"SSHADOW", b"SHADOW SUI", b"WELLCOME TO Shadow SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_18_00_19_56_d457dd8897.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSHADOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSHADOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

