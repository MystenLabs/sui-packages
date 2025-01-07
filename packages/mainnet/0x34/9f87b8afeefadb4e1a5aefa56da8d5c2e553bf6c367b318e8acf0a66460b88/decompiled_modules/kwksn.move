module 0x349f87b8afeefadb4e1a5aefa56da8d5c2e553bf6c367b318e8acf0a66460b88::kwksn {
    struct KWKSN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KWKSN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KWKSN>(arg0, 9, b"KWKSN", b"jejdb", b"hebe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/56858d6a-19fd-4f01-9ca4-9f762dac5229.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KWKSN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KWKSN>>(v1);
    }

    // decompiled from Move bytecode v6
}

