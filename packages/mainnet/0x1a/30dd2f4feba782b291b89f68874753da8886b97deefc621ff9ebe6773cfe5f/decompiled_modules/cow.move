module 0x1a30dd2f4feba782b291b89f68874753da8886b97deefc621ff9ebe6773cfe5f::cow {
    struct COW has drop {
        dummy_field: bool,
    }

    fun init(arg0: COW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COW>(arg0, 6, b"COW", b"MuuuCOW", b"Milky COW now on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D_D_D_D_D_D_N_D_N_D_D_D_2024_10_04_122519_d6d76d44bf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COW>>(v1);
    }

    // decompiled from Move bytecode v6
}

