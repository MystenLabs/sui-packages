module 0xf022f148ed6087b9ae6525ffc1853712b6ea07efca94bbac40f695949e3e9ac6::template {
    struct TEMPLATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEMPLATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEMPLATE>(arg0, 9, b"LAP", b"laptop", b"laptop this is a laptop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://jurassiq-bucket.s3.eu-north-1.amazonaws.com/image_2025-04-23_104518938.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEMPLATE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEMPLATE>>(v1);
    }

    // decompiled from Move bytecode v6
}

