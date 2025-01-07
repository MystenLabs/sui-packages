module 0xe1f382c18ca6d57b1ddfa7d3563481bdb5129e8e83dc0b84dbf60ac523147583::khai {
    struct KHAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KHAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KHAI>(arg0, 6, b"KHAI", b"KittenHaimer", b"KHAI created a revolutionary digital currency that is designed for simplicity, security, and accessibility.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GARFIELD_52d1bd5c91.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KHAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KHAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

