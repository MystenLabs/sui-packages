module 0x591e953261e15977b437cd3d60b845eecc9f380a6d5c6f67d36287c375512977::cigar {
    struct CIGAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIGAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CIGAR>(arg0, 6, b"Cigar", b"Cigaretteonsui", b"Smooth taste", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730974671156.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CIGAR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIGAR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

