module 0xcb009670e1e1cafbe497b03871cc3617fa3e1291394557736a612fa26970ccf3::seth {
    struct SETH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SETH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SETH>(arg0, 6, b"SETH", b"Sui ETH", b"Sui Ethereum", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_eth_48a4a5b010.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SETH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SETH>>(v1);
    }

    // decompiled from Move bytecode v6
}

