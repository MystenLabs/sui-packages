module 0xeb4010ce3bead4b2c6f25e602fd5a1404a18995835137ec02cd1381439bff10::bk {
    struct BK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BK>(arg0, 9, b"BK", b"Rebeccah ", b"A fun token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2b2d81d4-0269-43aa-ad13-b49794259194.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BK>>(v1);
    }

    // decompiled from Move bytecode v6
}

