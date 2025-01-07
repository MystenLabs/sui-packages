module 0xb5b79f31282c3bc5b1b68d9a03867e4ae5c18c298be34f4f61148660d87b8528::weeee {
    struct WEEEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEEEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEEEE>(arg0, 9, b"WEEEE", b"Weee", b"Weeeee", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c69e4873-3291-4683-b503-2074de1156ac.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEEEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEEEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

