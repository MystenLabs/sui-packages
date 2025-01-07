module 0x57298fa6da161fb9eb3779312fec40af8c675ac04b15e2e7d24c60780b655898::cap {
    struct CAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAP>(arg0, 6, b"CAP", b"caponsui", b"Lost everything using leverage, now I spot and chill", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/o_K72_M_Wyk_400x400_72fdf90afa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

