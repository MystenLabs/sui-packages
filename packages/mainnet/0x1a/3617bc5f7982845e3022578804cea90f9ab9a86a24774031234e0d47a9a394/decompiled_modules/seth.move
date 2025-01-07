module 0x1a3617bc5f7982845e3022578804cea90f9ab9a86a24774031234e0d47a9a394::seth {
    struct SETH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SETH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SETH>(arg0, 6, b"sETH", b"ETH(Sui)", b"Ethereum, now on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0386_802ce91911.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SETH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SETH>>(v1);
    }

    // decompiled from Move bytecode v6
}

