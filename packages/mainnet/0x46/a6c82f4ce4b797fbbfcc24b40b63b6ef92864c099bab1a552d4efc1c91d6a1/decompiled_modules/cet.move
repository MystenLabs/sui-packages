module 0x46a6c82f4ce4b797fbbfcc24b40b63b6ef92864c099bab1a552d4efc1c91d6a1::cet {
    struct CET has drop {
        dummy_field: bool,
    }

    fun init(arg0: CET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CET>(arg0, 6, b"CET", b"Colon-ER Trump", b"Hair Looks Amazing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_02_11_08_50_04_e5743b98cf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CET>>(v1);
    }

    // decompiled from Move bytecode v6
}

