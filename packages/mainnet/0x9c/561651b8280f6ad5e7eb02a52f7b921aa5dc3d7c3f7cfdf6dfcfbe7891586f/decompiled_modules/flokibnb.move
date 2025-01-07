module 0x9c561651b8280f6ad5e7eb02a52f7b921aa5dc3d7c3f7cfdf6dfcfbe7891586f::flokibnb {
    struct FLOKIBNB has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOKIBNB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOKIBNB>(arg0, 6, b"FLOKIBNB", b"Floki Binance Official", b"Clean contract without minting.  Tele: https://t.me/Floki_Binance", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/n1RgNGw.png"))), arg1);
        let v2 = v0;
        let v3 = @0x2e4915bd8f1e435b46aac2781513c6f74db7e539e4af01bff8cee90c769956db;
        0x2::coin::mint_and_transfer<FLOKIBNB>(&mut v2, 10000000000000000, v3, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLOKIBNB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOKIBNB>>(v2, v3);
    }

    // decompiled from Move bytecode v6
}

