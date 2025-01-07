module 0x725094a205511350ef40696ba71d0b41f4da8479742aac638f5d6e6a890265::suibaby {
    struct SUIBABY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBABY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBABY>(arg0, 6, b"SUIBABY", b"The Baby of Sui Universe", b"$SUIBABY is a new token in the Sui universe, designed to support and nurture emerging projects within the Sui network. By fostering growth and innovation, $SUIBABY aims to play a pivotal role in the development of the Sui ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUIBABY_0d22cfc587.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBABY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBABY>>(v1);
    }

    // decompiled from Move bytecode v6
}

