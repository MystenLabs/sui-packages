module 0xa0741a13952594ee696f526cab02796aa1f67acfd76fc0f2909bb9f7766c1aa6::aad {
    struct AAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAD>(arg0, 6, b"AAD", b"aaa dev", b"DEV is contemplating. About AAA AAA.. .. .. To take him to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1283_9b5aa4a79f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

