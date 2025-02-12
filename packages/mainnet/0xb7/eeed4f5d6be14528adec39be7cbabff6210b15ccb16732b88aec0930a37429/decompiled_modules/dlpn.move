module 0xb7eeed4f5d6be14528adec39be7cbabff6210b15ccb16732b88aec0930a37429::dlpn {
    struct DLPN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DLPN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DLPN>(arg0, 9, b"DLPN", b"Dolphin", b"Dolphin is the future of crypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ecb896db-f1ca-4b5c-b770-08dc9768a743.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DLPN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DLPN>>(v1);
    }

    // decompiled from Move bytecode v6
}

