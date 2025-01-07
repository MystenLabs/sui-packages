module 0xfe858ae3c4975b04588faae2db45a6f63eaa829e2cbbae20fbb7d29da2b4e7ef::dupc {
    struct DUPC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUPC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUPC>(arg0, 6, b"DUPC", b"DOUBLE UP CASINO", b"Official governance token of double up casino built on sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5791_e87029f8ba.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUPC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUPC>>(v1);
    }

    // decompiled from Move bytecode v6
}

