module 0x8d29408ea6637685bd775ccd217b78e78717a7050360c1eccd1babaac9a22c13::starry {
    struct STARRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: STARRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STARRY>(arg0, 6, b"STARRY", b"The Starry Night", b"\"The Starry Night\" by Vincent van Gogh is a renowned painting showing a vibrant, swirling night sky over a quiet town, known for its emotional depth and distinctive style.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Van_Gogh_Starry_Night_Google_Art_Project_jpg_0c103a6eeb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STARRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STARRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

