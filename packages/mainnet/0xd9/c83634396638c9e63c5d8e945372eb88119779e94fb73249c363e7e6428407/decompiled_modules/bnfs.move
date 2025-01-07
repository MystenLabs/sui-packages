module 0xd9c83634396638c9e63c5d8e945372eb88119779e94fb73249c363e7e6428407::bnfs {
    struct BNFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BNFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BNFS>(arg0, 9, b"BNFS", b"banafsh", b"BANAFSH IS THE NEW MEME COIN FOR PUMP YOU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/78e97eae-e612-4c5f-b0e2-bb8c8878eb9b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BNFS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BNFS>>(v1);
    }

    // decompiled from Move bytecode v6
}

