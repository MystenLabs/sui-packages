module 0xd7f83fcb682312b43b5f774d9d7eb81fc68c43a976b0b6ecf96eeab15ba9e5cf::deez {
    struct DEEZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEZ>(arg0, 6, b"DEEZ", b"DEEZ NUTZ", b"deez nuts", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/whitepaper_ad56956025.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEEZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

