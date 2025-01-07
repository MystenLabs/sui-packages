module 0x860a3da74e2641f7e683a253b35d70a4602f8a135e96552034c14c97f4147e2::brin {
    struct BRIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRIN>(arg0, 9, b"BRIN", b"Brain", b"practice math every day to have a better brain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0123e9d5-e7bc-4cd3-a1c3-8307baf76a2d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

