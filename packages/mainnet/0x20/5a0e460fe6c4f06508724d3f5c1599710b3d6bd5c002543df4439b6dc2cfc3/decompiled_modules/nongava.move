module 0x205a0e460fe6c4f06508724d3f5c1599710b3d6bd5c002543df4439b6dc2cfc3::nongava {
    struct NONGAVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NONGAVA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NONGAVA>(arg0, 6, b"NongAva", b"NONGAVA", b"Meet Nong Ava (), an adorable young tiger from Chiang Mai Night Safari in Thailand!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/FB_IMG_1732192489683_1e2c616f42.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NONGAVA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NONGAVA>>(v1);
    }

    // decompiled from Move bytecode v6
}

