module 0x13c1c25845a2e7edbcf52bebbc8f2727d3058fc95ea71546f2a23df0e3a87fd1::boobs {
    struct BOOBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOBS>(arg0, 6, b"BOOBS", b"BoobsCoin", b"The best  Boobs On SUI !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Boobcoin_39f500d6f7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

