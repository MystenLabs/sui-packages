module 0x8f23ef06cd7f4ccd1956222f3db4e59f05bc5fd602fa48097a8e344ea9a0dd8::f {
    struct F has drop {
        dummy_field: bool,
    }

    fun init(arg0: F, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<F>(arg0, 6, b"F", b"54", b"asdf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/default.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<F>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<F>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

