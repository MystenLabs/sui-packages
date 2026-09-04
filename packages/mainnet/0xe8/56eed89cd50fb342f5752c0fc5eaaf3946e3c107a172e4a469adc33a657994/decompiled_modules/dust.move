module 0xe856eed89cd50fb342f5752c0fc5eaaf3946e3c107a172e4a469adc33a657994::dust {
    struct DUST has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUST>(arg0, 3, b"DUST", b"Boomdust", x"426f6f6d6475737420e2809420766f6c6174696c65206d756e6974696f6e732d677261646520706f776465722066726f6d20746865205761737465732720726172657374206465706f736974732e2054686520626f74746c656e65636b206f66206576657279207265636970652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://boombots-production.up.railway.app/art/resources/dust.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DUST>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

