module 0xe8b52e3bd5744427f9cfc2ff702af27ffcf138f38c6ac55ba73eab9b8cb0e2b2::fds {
    struct FDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FDS>(arg0, 9, b"FDS", b"J", b"FV", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dda95189-2aae-42cb-9157-f5df262f27f5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

