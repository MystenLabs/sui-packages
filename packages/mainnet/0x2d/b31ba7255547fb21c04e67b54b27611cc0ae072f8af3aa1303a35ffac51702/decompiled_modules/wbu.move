module 0x2db31ba7255547fb21c04e67b54b27611cc0ae072f8af3aa1303a35ffac51702::wbu {
    struct WBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: WBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WBU>(arg0, 9, b"WBU", b"WIBU", b"Wibu token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/69194467-504f-4ef6-98e9-4ec12e8202d8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WBU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WBU>>(v1);
    }

    // decompiled from Move bytecode v6
}

