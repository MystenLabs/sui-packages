module 0x1458c6b329a1907129f19f86bed6e36b031dbca81c69a1ae2f713abe1c462c74::bhc {
    struct BHC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BHC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BHC>(arg0, 6, b"BHC", b"BlackHouse", b"OFFICIAL $BHC BlackHouse meme money: ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1761744051669.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BHC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BHC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

