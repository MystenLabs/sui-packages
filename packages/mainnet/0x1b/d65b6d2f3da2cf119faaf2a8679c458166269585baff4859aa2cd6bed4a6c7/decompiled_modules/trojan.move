module 0x1bd65b6d2f3da2cf119faaf2a8679c458166269585baff4859aa2cd6bed4a6c7::trojan {
    struct TROJAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROJAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROJAN>(arg0, 6, b"TROJAN", b"TROJAN SUI", b"TROJAN SUI is a viral meme coin on the SUI blockchain, inspired by digital viruses and built to infect the web with humor, utility, and community powe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_03aa343f09.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROJAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TROJAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

