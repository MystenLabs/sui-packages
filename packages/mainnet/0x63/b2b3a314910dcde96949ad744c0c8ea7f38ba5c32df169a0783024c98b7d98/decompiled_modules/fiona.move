module 0x63b2b3a314910dcde96949ad744c0c8ea7f38ba5c32df169a0783024c98b7d98::fiona {
    struct FIONA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIONA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIONA>(arg0, 6, b"FIONA", b"BLUE FIONA", b"Send it to bluemove $FIONA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3535_c095aa2e12.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIONA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIONA>>(v1);
    }

    // decompiled from Move bytecode v6
}

