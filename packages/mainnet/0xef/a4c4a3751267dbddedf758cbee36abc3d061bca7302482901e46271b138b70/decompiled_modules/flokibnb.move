module 0xefa4c4a3751267dbddedf758cbee36abc3d061bca7302482901e46271b138b70::flokibnb {
    struct FLOKIBNB has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOKIBNB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOKIBNB>(arg0, 6, b"FLOKIBNB", b"Floki Binance", b"Floki list on Binance.Buy FLOKIBNB to support Floki! Tele: https://t.me/Floki_Binance", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/n1RgNGw.png"))), arg1);
        let v2 = v0;
        let v3 = @0x2e4915bd8f1e435b46aac2781513c6f74db7e539e4af01bff8cee90c769956db;
        0x2::coin::mint_and_transfer<FLOKIBNB>(&mut v2, 1000000000, v3, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLOKIBNB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOKIBNB>>(v2, v3);
    }

    // decompiled from Move bytecode v6
}

