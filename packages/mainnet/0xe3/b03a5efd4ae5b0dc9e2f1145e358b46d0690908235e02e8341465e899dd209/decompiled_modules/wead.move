module 0xe3b03a5efd4ae5b0dc9e2f1145e358b46d0690908235e02e8341465e899dd209::wead {
    struct WEAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEAD>(arg0, 6, b"WEAD", b"WEAD SUI", b"The most memeable orange in existence, here to annoy sui and become the best memecoin out there.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_05_09_22_30_04_d46c40bf8b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WEAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

