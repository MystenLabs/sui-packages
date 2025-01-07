module 0x22fc0c01eb0a5ea047f503b8919c5ed5238b77fdeb507370381add053c22cfe3::suicolon {
    struct SUICOLON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICOLON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICOLON>(arg0, 6, b"SUIColon", b"Colon", x"436f6c6f6e20546f6b656e206973206120756e69717565206469676974616c2061737365740a746861742063656c6562726174657320616e6420686f6e6f72732074686520726963680a6c6567616379206f6620646f672d7468656d65642063727970746f63757272656e6369657320696e0a7468652063727970746f20776f726c642e200a486527732074686520466174686572206f6620446f67652028446f676520697320616c736f0a6b6e6f776e206173204b61626f73752069726c292c2074686520707265636564656e74206f660a616c6c20646f67206d656d65636f696e73206576657220746f2065786973742e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/102_342731f24f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICOLON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICOLON>>(v1);
    }

    // decompiled from Move bytecode v6
}

