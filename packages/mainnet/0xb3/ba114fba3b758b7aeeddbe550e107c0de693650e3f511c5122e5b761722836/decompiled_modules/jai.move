module 0xb3ba114fba3b758b7aeeddbe550e107c0de693650e3f511c5122e5b761722836::jai {
    struct JAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAI>(arg0, 6, b"JAI", b"Jelly AI", x"4a656c6c79416c2773206d697373696f6e20697320746f2070726f7669646520796f752077697468206120626574746572206675747572652e20f09f92af2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731009962195.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

