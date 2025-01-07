module 0xf2a92abae47d7df02ce9292bf8e4ba0d9c3a5727b7b471b5644cf5938084b39f::suineku {
    struct SUINEKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINEKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINEKU>(arg0, 6, b"SUINEKU", b"Sui Suneku", b"SuinekU is a Snake from Sui Chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2022_07_31_20_26_41_0c9530f93f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINEKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINEKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

