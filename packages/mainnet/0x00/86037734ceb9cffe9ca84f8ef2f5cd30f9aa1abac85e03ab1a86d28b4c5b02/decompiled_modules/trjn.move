module 0x86037734ceb9cffe9ca84f8ef2f5cd30f9aa1abac85e03ab1a86d28b4c5b02::trjn {
    struct TRJN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRJN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRJN>(arg0, 6, b"TRJN", b"TROJAN", b"$TROJAN SUI is a viral meme coin on the SUI blockchain, inspired by digital viruses and built to infect the web with humor, utility, and community power.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_4_5e9540d390.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRJN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRJN>>(v1);
    }

    // decompiled from Move bytecode v6
}

