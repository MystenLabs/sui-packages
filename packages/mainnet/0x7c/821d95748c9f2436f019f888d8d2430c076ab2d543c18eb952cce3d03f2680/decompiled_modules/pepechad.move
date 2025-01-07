module 0x7c821d95748c9f2436f019f888d8d2430c076ab2d543c18eb952cce3d03f2680::pepechad {
    struct PEPECHAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPECHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPECHAD>(arg0, 6, b"PEPECHAD", b"PEPE THE CHAD", b"PEPECHAD is Here! Bigger, stronger, and ready to dominate the crypto world in $SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_f2ec9dfdae.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPECHAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPECHAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

