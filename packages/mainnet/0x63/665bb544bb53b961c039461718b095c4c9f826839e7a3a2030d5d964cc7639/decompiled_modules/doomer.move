module 0x63665bb544bb53b961c039461718b095c4c9f826839e7a3a2030d5d964cc7639::doomer {
    struct DOOMER has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOOMER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOOMER>(arg0, 6, b"DOOMER", b"SUI DOOMER", b"Lost everything in life? Dont worry, you can make it all back with $Doomer on SUI Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUI_DOOMER_LOGO_bc44e3921c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOOMER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOOMER>>(v1);
    }

    // decompiled from Move bytecode v6
}

