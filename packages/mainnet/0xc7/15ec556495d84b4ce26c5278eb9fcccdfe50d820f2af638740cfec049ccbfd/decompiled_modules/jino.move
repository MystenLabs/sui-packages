module 0xc715ec556495d84b4ce26c5278eb9fcccdfe50d820f2af638740cfec049ccbfd::jino {
    struct JINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: JINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JINO>(arg0, 6, b"Jino", b"Jimmy & Nova", b"CUTE TWIN DOGS ON SUI ECOSYSTEM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000153067_d50ba6684d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JINO>>(v1);
    }

    // decompiled from Move bytecode v6
}

