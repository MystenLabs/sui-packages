module 0xd5573a5e5457b85ac9bfd39db6cb6aa05ee3bb01458017707f02df509e4bcd63::jckoa {
    struct JCKOA has drop {
        dummy_field: bool,
    }

    fun init(arg0: JCKOA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JCKOA>(arg0, 9, b"JCKOA", b"Hh", b"Jxkka", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bf30d03b-b06e-40f1-b642-eb27cd5a5f76.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JCKOA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JCKOA>>(v1);
    }

    // decompiled from Move bytecode v6
}

