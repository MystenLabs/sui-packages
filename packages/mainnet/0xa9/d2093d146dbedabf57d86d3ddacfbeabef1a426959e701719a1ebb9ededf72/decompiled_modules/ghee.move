module 0xa9d2093d146dbedabf57d86d3ddacfbeabef1a426959e701719a1ebb9ededf72::ghee {
    struct GHEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHEE>(arg0, 6, b"GHEE", b"Ghee On Sui", b"a new cult classic ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6fv_Cj53y_400x400_79bcbe4210.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GHEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

