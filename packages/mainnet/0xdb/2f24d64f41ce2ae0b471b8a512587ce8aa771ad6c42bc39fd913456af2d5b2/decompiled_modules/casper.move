module 0xdb2f24d64f41ce2ae0b471b8a512587ce8aa771ad6c42bc39fd913456af2d5b2::casper {
    struct CASPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: CASPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CASPER>(arg0, 6, b"CASPER", b"Casper on Sui", b"Casper, the friendly ghost you know and love is now haunting the Sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Casper_1_2f9658c706.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CASPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CASPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

