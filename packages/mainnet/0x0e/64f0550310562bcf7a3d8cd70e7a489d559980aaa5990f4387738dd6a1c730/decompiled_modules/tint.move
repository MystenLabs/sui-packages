module 0xe64f0550310562bcf7a3d8cd70e7a489d559980aaa5990f4387738dd6a1c730::tint {
    struct TINT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TINT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TINT>(arg0, 9, b"TINT", b"TINT", b"T and T", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkiPZX7sHRjB8655icQZ-6YD-KpJD5aP0eNw&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TINT>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TINT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TINT>>(v1);
    }

    // decompiled from Move bytecode v6
}

