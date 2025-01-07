module 0x41c686fc58ad0b6700a7e530cb355da9d44f17ad0dda7155bfac7beb04d3f71::suib {
    struct SUIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIB>(arg0, 6, b"Suib", b"Suiberian tiger", b"Suiberian tiger ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9b5bcc2c_ea99_4380_92b3_4b6f3e633040_4edd9d4a2d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

