module 0x7482b255744e1a94776baef4edde231ab1c773b80b9cbe45d1051d318514c973::raff {
    struct RAFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAFF>(arg0, 6, b"RAFF", b"RAFF SUI", x"486920496d2024526166662054686520526166662046726f6d20546865204c616e64204f6620536f6c616e6120416e6420492043616e742053746f702047726f77696e672e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/79w_F29oe_400x400_ea8081197c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

