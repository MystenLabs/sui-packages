module 0x243a77ac32de0575b0aeaa021c2824e8e69799407a6ef41e92514c4dbbb4b651::deep_seek {
    struct DEEP_SEEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEP_SEEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEP_SEEK>(arg0, 9, b"DEEP", b"Deep Seek", b"The sui Deep Seek Unofficial", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775525324874-9854b6565858b949f17ba765a77fc91a.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<DEEP_SEEK>>(0x2::coin::mint<DEEP_SEEK>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEEP_SEEK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEP_SEEK>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

