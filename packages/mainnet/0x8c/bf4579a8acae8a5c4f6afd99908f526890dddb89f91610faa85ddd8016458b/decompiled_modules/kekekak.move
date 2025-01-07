module 0x8cbf4579a8acae8a5c4f6afd99908f526890dddb89f91610faa85ddd8016458b::kekekak {
    struct KEKEKAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEKEKAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEKEKAK>(arg0, 6, b"Kekekak", b"Keke", x"4b656b656b616b636f696e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048933_f455a41455.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEKEKAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KEKEKAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

