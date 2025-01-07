module 0x2e6b59bcf4ed8d337cbee3a9e7abe7d795377fc64db6029d4b71b63b8aebb9df::fratt {
    struct FRATT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRATT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRATT>(arg0, 6, b"FRATT", b"Frogg & Ratt", b"Meet Frogg and Ratt. The 2 degens riding the Suinami", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/QZAH_7_Bu_C_400x400_1_769cc57d52.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRATT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRATT>>(v1);
    }

    // decompiled from Move bytecode v6
}

