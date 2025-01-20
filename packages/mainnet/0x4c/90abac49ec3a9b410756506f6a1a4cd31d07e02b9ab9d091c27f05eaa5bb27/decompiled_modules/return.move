module 0x4c90abac49ec3a9b410756506f6a1a4cd31d07e02b9ab9d091c27f05eaa5bb27::return {
    struct RETURN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RETURN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RETURN>(arg0, 6, b"RETURN", b"Trump's comeback sui", b"$RETURN celebrates Mr. Trump's official inauguration as the 47th President, marking his historic comeback to leadership", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250121_032854_658_0422d4213f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RETURN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RETURN>>(v1);
    }

    // decompiled from Move bytecode v6
}

