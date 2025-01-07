module 0x4a603b4028492b4baf2fc2a464b71fc57858ca216434afc50a7741c4dff78177::obc {
    struct OBC has drop {
        dummy_field: bool,
    }

    fun init(arg0: OBC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OBC>(arg0, 9, b"OBC", b"OBACRYPTO", b"TRADING OF CRYPTOCURRENCY, BUYING AND SELLING OF BTC ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a6ac95c7-3f26-476f-afae-b7753c7c6142.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OBC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OBC>>(v1);
    }

    // decompiled from Move bytecode v6
}

