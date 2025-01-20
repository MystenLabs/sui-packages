module 0xdb0fe5ac61b4c6dc426e86ef9770c4b7ab4d1864b072dce8449ba970e818689::eyeschico {
    struct EYESCHICO has drop {
        dummy_field: bool,
    }

    fun init(arg0: EYESCHICO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EYESCHICO>(arg0, 9, b"Eyeschico", x"f09f9180", x"f09f9180f09f9180", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/29e1a901b0e6e643fda3107daa459928blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EYESCHICO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EYESCHICO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

