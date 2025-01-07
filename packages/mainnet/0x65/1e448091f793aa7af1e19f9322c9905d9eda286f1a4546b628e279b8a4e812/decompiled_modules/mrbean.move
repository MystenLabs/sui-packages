module 0x651e448091f793aa7af1e19f9322c9905d9eda286f1a4546b628e279b8a4e812::mrbean {
    struct MRBEAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRBEAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRBEAN>(arg0, 6, b"MrBean", b"MrBeanisious", b"Mr Beanisious on Sui. Very Beeeean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1200x1200bf_60_2297362119_7a641bd68c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRBEAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MRBEAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

