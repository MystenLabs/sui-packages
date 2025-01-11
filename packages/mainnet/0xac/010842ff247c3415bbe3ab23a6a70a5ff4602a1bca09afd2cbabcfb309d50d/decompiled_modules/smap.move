module 0xac010842ff247c3415bbe3ab23a6a70a5ff4602a1bca09afd2cbabcfb309d50d::smap {
    struct SMAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMAP>(arg0, 6, b"SMAP", b"Sui Meme After Party", x"535549204d656d652041667465722050617274790a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736609046768.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMAP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMAP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

