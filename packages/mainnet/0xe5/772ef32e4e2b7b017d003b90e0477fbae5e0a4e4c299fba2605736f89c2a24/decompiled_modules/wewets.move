module 0xe5772ef32e4e2b7b017d003b90e0477fbae5e0a4e4c299fba2605736f89c2a24::wewets {
    struct WEWETS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEWETS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEWETS>(arg0, 9, b"WEWETS", b"TSOnline", b"commemorative token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/16aaf03f-2904-4e90-9562-bd11b3acb16e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEWETS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEWETS>>(v1);
    }

    // decompiled from Move bytecode v6
}

