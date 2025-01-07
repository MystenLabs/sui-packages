module 0x552ae7578bb7e1610462d2207e42a529036f8e6565df5d35903a771c6f42d654::popcat {
    struct POPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPCAT>(arg0, 6, b"PopCat", b"PopCat Sui", x"506f70636174204d656d636f696e206e6f77206f6e205355490a4c65742773206d6f6f6e656420697421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/it2_VZH_Lf_400x400_a4e8115b71.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

