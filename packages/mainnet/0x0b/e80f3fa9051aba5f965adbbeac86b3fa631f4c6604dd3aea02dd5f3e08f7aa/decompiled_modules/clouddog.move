module 0xbe80f3fa9051aba5f965adbbeac86b3fa631f4c6604dd3aea02dd5f3e08f7aa::clouddog {
    struct CLOUDDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLOUDDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLOUDDOG>(arg0, 6, b"CloudDOG", b"CloudDOG On Sui", b"CloudDOG On Sui GO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cloud_DOG_ON_BASE_ba82ba5c0d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLOUDDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLOUDDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

