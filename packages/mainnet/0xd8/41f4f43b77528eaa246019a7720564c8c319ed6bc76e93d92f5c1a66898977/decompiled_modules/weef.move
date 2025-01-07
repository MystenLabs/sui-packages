module 0xd841f4f43b77528eaa246019a7720564c8c319ed6bc76e93d92f5c1a66898977::weef {
    struct WEEF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEEF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEEF>(arg0, 9, b"WEEF", b"Wolf", b"The best in hunting me coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a8516b1d-4e0c-4e05-8bbf-3b534914584a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEEF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEEF>>(v1);
    }

    // decompiled from Move bytecode v6
}

