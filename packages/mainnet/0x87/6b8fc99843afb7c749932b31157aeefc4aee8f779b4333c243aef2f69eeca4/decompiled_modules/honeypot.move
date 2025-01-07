module 0x876b8fc99843afb7c749932b31157aeefc4aee8f779b4333c243aef2f69eeca4::honeypot {
    struct HONEYPOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HONEYPOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<HONEYPOT>(arg0, 6, b"HONEYPOT", b"HoneyPot", b"honey!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/shiba_dogs_d55def826b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HONEYPOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<HONEYPOT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HONEYPOT>>(v2);
    }

    // decompiled from Move bytecode v6
}

