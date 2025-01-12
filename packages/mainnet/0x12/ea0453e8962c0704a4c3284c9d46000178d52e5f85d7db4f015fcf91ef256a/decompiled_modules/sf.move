module 0x12ea0453e8962c0704a4c3284c9d46000178d52e5f85d7db4f015fcf91ef256a::sf {
    struct SF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SF>(arg0, 6, b"sf", b"d", b"sfsf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/1bd9898c-7bca-4d7f-a680-c5329c7e529c.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

