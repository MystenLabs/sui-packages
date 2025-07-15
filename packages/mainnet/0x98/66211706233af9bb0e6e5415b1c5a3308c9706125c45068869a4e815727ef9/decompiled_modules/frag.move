module 0x9866211706233af9bb0e6e5415b1c5a3308c9706125c45068869a4e815727ef9::frag {
    struct FRAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRAG>(arg0, 6, b"Frag", b" fragmented", b"it's a feeling", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1752590787686.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRAG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRAG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

