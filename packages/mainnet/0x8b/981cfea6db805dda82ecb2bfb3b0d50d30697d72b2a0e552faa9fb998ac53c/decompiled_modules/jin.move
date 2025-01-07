module 0x8b981cfea6db805dda82ecb2bfb3b0d50d30697d72b2a0e552faa9fb998ac53c::jin {
    struct JIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JIN>(arg0, 6, b"JIN", b"sui jin", b"The most handsome puppy in Sui. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Kakao_Talk_20241002_212331497_25acfb78ea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

