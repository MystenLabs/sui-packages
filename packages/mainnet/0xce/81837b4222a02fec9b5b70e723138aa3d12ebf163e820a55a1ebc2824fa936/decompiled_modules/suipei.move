module 0xce81837b4222a02fec9b5b70e723138aa3d12ebf163e820a55a1ebc2824fa936::suipei {
    struct SUIPEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPEI>(arg0, 6, b"Suipei", b"SUIPEI", b"Meet Suipei the feline warrior raised in a small ancient village in China by his elderly master PeiPei, an expert in the ancient art of \"Feline Krypto Fu.\"  The master taught Suipei the importance of honor, loyalty, and discipline. Determined to make his way to the ERC20 blockchain just like his master PeiPei, Suipei decided to confront his fears and launch a new Cat Meta. This Feline warrior is ready to PAWMP the chart and onboard a community like no other. It will be HiPaws Allround!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suipei_lan_3e0dc0e342.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPEI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPEI>>(v1);
    }

    // decompiled from Move bytecode v6
}

