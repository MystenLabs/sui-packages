module 0xd10f102205e41062a148fa72629d489c63c40980cfe1cc89875adb0249aedad6::suiberry {
    struct SUIBERRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBERRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBERRY>(arg0, 9, b"SUIBERRY", b"SUIBERRY", b" Prettiest Dog On SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/isGpHkm.jpeg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIBERRY>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIBERRY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBERRY>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

