module 0xf4b59e1e4d1292a850c2494216078d49a8ca8bc9aa6001d8eb8e46182a5f04b8::dopin {
    struct DOPIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOPIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOPIN>(arg0, 6, b"DOPIN", b"DopinTheDolphin", b"The doped community making waves on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241007_111839_b5454e7600.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOPIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOPIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

