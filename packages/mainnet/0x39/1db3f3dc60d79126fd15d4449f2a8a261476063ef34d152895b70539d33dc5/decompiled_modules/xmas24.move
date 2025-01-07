module 0x391db3f3dc60d79126fd15d4449f2a8a261476063ef34d152895b70539d33dc5::xmas24 {
    struct XMAS24 has drop {
        dummy_field: bool,
    }

    fun init(arg0: XMAS24, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XMAS24>(arg0, 6, b"XMAS24", b"Merry Christmas 2024", b"XMAS24 is the holiday meme token bringing festive cheer to the blockchain this season. Celebrate the spirit of Christmas with a sprinkle of humor and a dash of holiday magic as we spread joy through the crypto community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731072745774.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XMAS24>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XMAS24>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

