module 0xc96181304810ffe09f1db13d3a3ebda21756c1e85184d435e962a2671614b42b::snfg {
    struct SNFG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNFG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNFG>(arg0, 6, b"SNFG", b"Snoop Frogg", b"Caught Snoop Frogg with the stash again.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1011_cede4d8777.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNFG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNFG>>(v1);
    }

    // decompiled from Move bytecode v6
}

