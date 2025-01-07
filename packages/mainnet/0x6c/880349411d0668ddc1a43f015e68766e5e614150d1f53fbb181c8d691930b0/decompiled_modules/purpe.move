module 0x6c880349411d0668ddc1a43f015e68766e5e614150d1f53fbb181c8d691930b0::purpe {
    struct PURPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PURPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PURPE>(arg0, 6, b"PURPE", b"Purple Pepe", b"Get ready to embark on an extraordinary journey with the launch of Purple Pepe that has already sparked a rapidly expanding and incredibly vibrant community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735008451508.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PURPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PURPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

