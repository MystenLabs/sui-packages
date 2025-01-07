module 0xd3fbdf11b09b0e5cc5ce2a317e4b18ddfff535543aee58df78eb6b1fbfa92348::fds {
    struct FDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FDS>(arg0, 9, b"FDS", b"J", b"FV", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8ab31ebf-f302-47fa-b6eb-349466a03fda.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

