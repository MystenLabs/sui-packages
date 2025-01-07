module 0xebbc077ec82b53e933de5c44a1c1b12e251353648a0d86b7646410bf29b15e20::dml {
    struct DML has drop {
        dummy_field: bool,
    }

    fun init(arg0: DML, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DML>(arg0, 9, b"DML", b"Dhamal", b"Dhamal is native meme coin on sui blockchain ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ce765a35-1e9f-4fbb-b338-a48a22068b3c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DML>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DML>>(v1);
    }

    // decompiled from Move bytecode v6
}

