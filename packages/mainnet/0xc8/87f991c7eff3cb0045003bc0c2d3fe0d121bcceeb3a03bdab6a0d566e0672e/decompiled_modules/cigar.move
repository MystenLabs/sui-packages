module 0xc887f991c7eff3cb0045003bc0c2d3fe0d121bcceeb3a03bdab6a0d566e0672e::cigar {
    struct CIGAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIGAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CIGAR>(arg0, 6, b"Cigar", b"Cigarette On Sui", b"Smooth taste", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730978362096.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CIGAR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIGAR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

