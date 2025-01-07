module 0xd085025430b1bddc456569941ad2c6876e41238766993e7873090494d1d4a01b::oct {
    struct OCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCT>(arg0, 6, b"Oct", b"October", b"October is the holy month of Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1140_dc2dde53ac_7bb4d68fd3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCT>>(v1);
    }

    // decompiled from Move bytecode v6
}

