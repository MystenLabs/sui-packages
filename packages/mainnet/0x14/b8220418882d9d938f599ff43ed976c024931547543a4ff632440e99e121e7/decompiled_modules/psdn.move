module 0x14b8220418882d9d938f599ff43ed976c024931547543a4ff632440e99e121e7::psdn {
    struct PSDN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSDN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSDN>(arg0, 6, b"PSDN", b"POSUIDON", b"GOD OF WATER!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/poseidon_image_2_73a9e564cb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSDN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PSDN>>(v1);
    }

    // decompiled from Move bytecode v6
}

