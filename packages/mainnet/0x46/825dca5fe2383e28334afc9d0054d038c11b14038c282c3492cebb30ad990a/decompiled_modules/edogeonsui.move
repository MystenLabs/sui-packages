module 0x46825dca5fe2383e28334afc9d0054d038c11b14038c282c3492cebb30ad990a::edogeonsui {
    struct EDOGEONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: EDOGEONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EDOGEONSUI>(arg0, 6, b"EDOGEONSUI", b"First Elon Doge on Sui", b"First Real Doge on Sui which was inspired from Elon. Thoughts behind the project are so serious and mind blowing. First target 10 M $ market cap which will make Mexc listing easy. After MEXC , other listings will come and targets will go for 100 M $ and so on...Project will never stop.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Elondoge_7a15fef4b7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EDOGEONSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EDOGEONSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

