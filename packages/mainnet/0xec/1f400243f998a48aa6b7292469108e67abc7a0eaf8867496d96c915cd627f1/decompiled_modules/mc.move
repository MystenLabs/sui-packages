module 0xec1f400243f998a48aa6b7292469108e67abc7a0eaf8867496d96c915cd627f1::mc {
    struct MC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MC>(arg0, 9, b"MC", b"Miracle", b"This is Miracle", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/60b177a0-5ecf-4b67-8826-335332b0c89d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MC>>(v1);
    }

    // decompiled from Move bytecode v6
}

