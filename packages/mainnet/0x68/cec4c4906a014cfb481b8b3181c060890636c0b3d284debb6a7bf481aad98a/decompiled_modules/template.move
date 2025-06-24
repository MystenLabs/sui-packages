module 0x68cec4c4906a014cfb481b8b3181c060890636c0b3d284debb6a7bf481aad98a::template {
    struct TEMPLATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEMPLATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEMPLATE>(arg0, 9, b"RIVIAV2", b"GeraltV2", b"Geralt of rivia v2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://jurassiq-prod.s3.eu-north-1.amazonaws.com/HD-wallpaper-geralt-fantasy-the-witcher-the-face-man-witcher-inna-vjuzhanina-art-luminis.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEMPLATE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEMPLATE>>(v1);
    }

    // decompiled from Move bytecode v6
}

