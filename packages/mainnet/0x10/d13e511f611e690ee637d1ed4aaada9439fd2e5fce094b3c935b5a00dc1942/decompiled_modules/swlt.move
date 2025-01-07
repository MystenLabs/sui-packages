module 0x10d13e511f611e690ee637d1ed4aaada9439fd2e5fce094b3c935b5a00dc1942::swlt {
    struct SWLT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWLT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWLT>(arg0, 6, b"SWLT", b"SuiWallet", b"This is just a meme token issued by sui, have fun :D", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Wallet_hdr_305209adfc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWLT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWLT>>(v1);
    }

    // decompiled from Move bytecode v6
}

