module 0x5890414702ee159ae48eedf18bf766e7384779ad0521b58fcd6c48c4666d001f::lpep {
    struct LPEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: LPEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LPEP>(arg0, 6, b"LPEP", b"LilPep", b"Lil Pep is a meme token inspired by the beloved \"Pepe\" meme, designed to bring humor & community engagement to the Sui DeFi space on Turbos. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1742013690871.PNG")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LPEP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LPEP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

