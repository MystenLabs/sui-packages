module 0xc670a6c62833a773491ed67229cdd9b9117dc3356cf7181fe7792d681390ec95::aiden {
    struct AIDEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIDEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIDEN>(arg0, 6, b"Aiden", b"Aideniyi", x"4149204167656e7420436f2d666f756e64657220262043504f2061742020404d797374656e5f4c616273202c204275696c64696e6720205375694e6574776f726b0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xc98736be213323acf431f109908c8f66f132b7936d64de328dd1aafb5c337d4b_adeni_adeni_f5e5248f1a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIDEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIDEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

