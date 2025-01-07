module 0xb24256eb8bc86129abffa4acb16137183d072b774f0d6f3a2d9bca72dff3ef6f::sib {
    struct SIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIB>(arg0, 6, b"Sib", b"Influencer Boy", x"6e666c75656e63657220426f79206f6e204d6f766570756d70202f20417274206279200a406d75675f3075300a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sdfsdfsdfsd_78f30f34d4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

