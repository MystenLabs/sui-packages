module 0xcae40fb477cb315ec5c5bd4b5549e7e8d05e07bef29966e19d1eb13b9240a27f::catrus {
    struct CATRUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATRUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATRUS>(arg0, 6, b"CATRUS", b"Walrus Cat", b"Cat identify as a Walrus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/catrus_profil_b4e7dda3c3.JPEG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATRUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATRUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

