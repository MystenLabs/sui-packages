module 0xa47e4cc1c8f46f7613ea297808437406461aa65a987d6ea3182e0c589ce9e5cb::khanh {
    struct KHANH has drop {
        dummy_field: bool,
    }

    fun init(arg0: KHANH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KHANH>(arg0, 9, b"khanh123", b"haha", b"haha", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"haha")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KHANH>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KHANH>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<KHANH>>(v2);
    }

    // decompiled from Move bytecode v6
}

