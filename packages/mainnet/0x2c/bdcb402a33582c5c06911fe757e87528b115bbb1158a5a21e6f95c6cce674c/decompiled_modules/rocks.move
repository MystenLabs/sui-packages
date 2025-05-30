module 0x2cbdcb402a33582c5c06911fe757e87528b115bbb1158a5a21e6f95c6cce674c::rocks {
    struct ROCKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROCKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROCKS>(arg0, 6, b"ROCKS", b"MOONROCKS", b"MOONROCKS ($ROCK) is a community-driven meme coin built on the fast, scalable Sui blockchain. Designed for speed, simplicity, and pure entertainment value, MOONROCKS embraces the culture of crypto while offering a fun, lightweight asset for traders", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1748618806415.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROCKS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROCKS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

