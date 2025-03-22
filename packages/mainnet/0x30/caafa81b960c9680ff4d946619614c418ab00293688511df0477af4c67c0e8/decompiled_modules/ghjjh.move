module 0x30caafa81b960c9680ff4d946619614c418ab00293688511df0477af4c67c0e8::ghjjh {
    struct GHJJH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHJJH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHJJH>(arg0, 9, b"GHJJH", b"hghg", b"hi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/3d1da25638f46c809144317d13af71d5blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GHJJH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHJJH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

