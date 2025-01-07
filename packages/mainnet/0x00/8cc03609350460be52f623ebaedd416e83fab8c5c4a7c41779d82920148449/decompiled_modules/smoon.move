module 0x8cc03609350460be52f623ebaedd416e83fab8c5c4a7c41779d82920148449::smoon {
    struct SMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOON>(arg0, 6, b"SMOON", b"SuiMoon", x"54686520726f636b20636f6e74726f6c73206f75722064657374696e7920616e64205375692064657374696e7920697320746865206d6f6f6e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_924f69e93f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

