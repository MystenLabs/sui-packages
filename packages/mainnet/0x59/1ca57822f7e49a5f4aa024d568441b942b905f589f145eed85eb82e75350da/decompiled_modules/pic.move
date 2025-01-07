module 0x591ca57822f7e49a5f4aa024d568441b942b905f589f145eed85eb82e75350da::pic {
    struct PIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIC>(arg0, 9, b"PIC", b"PICTURE", b"MEMORI PICTURE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b097396a-fd21-4f5a-92a5-b5bd4107015b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

