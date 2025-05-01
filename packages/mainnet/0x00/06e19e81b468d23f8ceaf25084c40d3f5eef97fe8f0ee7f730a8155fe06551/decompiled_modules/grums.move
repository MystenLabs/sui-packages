module 0x6e19e81b468d23f8ceaf25084c40d3f5eef97fe8f0ee7f730a8155fe06551::grums {
    struct GRUMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRUMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRUMS>(arg0, 6, b"GRUMS", b"Grums On Sui", b"Mischievous intelligence", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pump_IMG_7c430841e5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRUMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRUMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

