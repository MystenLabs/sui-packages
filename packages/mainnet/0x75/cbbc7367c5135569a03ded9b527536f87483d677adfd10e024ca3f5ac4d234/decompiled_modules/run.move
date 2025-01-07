module 0x75cbbc7367c5135569a03ded9b527536f87483d677adfd10e024ca3f5ac4d234::run {
    struct RUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUN>(arg0, 9, b"RUN", b"ruin", b"ruined ruin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/73e343b8-9d52-4786-8794-49b47eb4a96b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

