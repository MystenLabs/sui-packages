module 0x50ff6ca6852cb9dc240f59fcc79afa3ff47391ef473d9053a93b002b9e7d156a::zack {
    struct ZACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZACK>(arg0, 6, b"ZACK", b"Captain Zack", b"$ZACK ayy ayy Captain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Karya_Seni_Tanpa_Judul_73_1371ce38ee.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZACK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

