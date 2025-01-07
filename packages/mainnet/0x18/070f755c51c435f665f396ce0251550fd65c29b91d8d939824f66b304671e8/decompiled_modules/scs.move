module 0x18070f755c51c435f665f396ce0251550fd65c29b91d8d939824f66b304671e8::scs {
    struct SCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCS>(arg0, 6, b"SCS", b"Stand Chill Sui", b"Hello America", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_01_07_11_04_7bbfcc09e6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCS>>(v1);
    }

    // decompiled from Move bytecode v6
}

