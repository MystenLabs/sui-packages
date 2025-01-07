module 0x67fab693995c9ccff52f8f1aa79aafdf04b616fc0a31ad2e87170a13d3840773::zim {
    struct ZIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZIM>(arg0, 6, b"ZIM", b"INVADER ZIM", b"Zim is a meme-coin category cryptocurrency inspired by the popular animated series Invader Zim (Invader Zim). This iconic animated series from Nickelodeon, created by Jhonen Vasquez,", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000042093_f54e34641e.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZIM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZIM>>(v1);
    }

    // decompiled from Move bytecode v6
}

