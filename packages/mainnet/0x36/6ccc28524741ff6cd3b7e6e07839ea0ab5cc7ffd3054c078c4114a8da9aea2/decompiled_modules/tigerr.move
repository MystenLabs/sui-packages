module 0x366ccc28524741ff6cd3b7e6e07839ea0ab5cc7ffd3054c078c4114a8da9aea2::tigerr {
    struct TIGERR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIGERR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIGERR>(arg0, 9, b"TIGERR", b"Tiger", b"Crying Tiger", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/821645a2-bc25-4278-b1dd-5c51eec8a0bc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIGERR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIGERR>>(v1);
    }

    // decompiled from Move bytecode v6
}

