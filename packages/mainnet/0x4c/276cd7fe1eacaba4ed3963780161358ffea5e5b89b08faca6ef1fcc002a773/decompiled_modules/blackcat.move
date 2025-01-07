module 0x4c276cd7fe1eacaba4ed3963780161358ffea5e5b89b08faca6ef1fcc002a773::blackcat {
    struct BLACKCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLACKCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLACKCAT>(arg0, 6, b"Blackcat", b"Cuteblackcat", b"The legendary black cat has mysterious abilities", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/screenshot_20241022_152945_072e333bfc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLACKCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLACKCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

