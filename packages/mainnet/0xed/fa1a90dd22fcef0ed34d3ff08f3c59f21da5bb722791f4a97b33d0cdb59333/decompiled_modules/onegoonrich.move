module 0xedfa1a90dd22fcef0ed34d3ff08f3c59f21da5bb722791f4a97b33d0cdb59333::onegoonrich {
    struct ONEGOONRICH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONEGOONRICH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONEGOONRICH>(arg0, 6, b"ONEGOONRICH", b"Crypto Messiah", b"1GoonRich The Crypto Messiah, He has been a Sui Chad for a bit! This is a community Token no dev, but Ig 1s made so come join sui chads, Some supply has been sent to 1GoonRich!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZZX_4660_5ca88ed2dc.JPEG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONEGOONRICH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ONEGOONRICH>>(v1);
    }

    // decompiled from Move bytecode v6
}

