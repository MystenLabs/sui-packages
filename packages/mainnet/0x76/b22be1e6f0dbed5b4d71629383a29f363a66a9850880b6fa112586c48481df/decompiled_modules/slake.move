module 0x76b22be1e6f0dbed5b4d71629383a29f363a66a9850880b6fa112586c48481df::slake {
    struct SLAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLAKE>(arg0, 6, b"SLAKE", b"SLAKE ON SUI", b"SLAKE is the next", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ok_06071a263c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

