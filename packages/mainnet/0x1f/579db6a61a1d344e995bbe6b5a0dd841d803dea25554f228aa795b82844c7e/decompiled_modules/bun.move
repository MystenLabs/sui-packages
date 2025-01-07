module 0x1f579db6a61a1d344e995bbe6b5a0dd841d803dea25554f228aa795b82844c7e::bun {
    struct BUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUN>(arg0, 6, b"BUN", b"FUNNY Bunny", b"The Bunny is on the stage!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730955254255.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

