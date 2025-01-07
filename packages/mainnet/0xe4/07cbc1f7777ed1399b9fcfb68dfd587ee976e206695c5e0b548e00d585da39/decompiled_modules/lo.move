module 0xe407cbc1f7777ed1399b9fcfb68dfd587ee976e206695c5e0b548e00d585da39::lo {
    struct LO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LO>(arg0, 9, b"LO", b"Long", b"Lo to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0074a2cc-1bdd-46d9-8556-0c9f4e355501.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LO>>(v1);
    }

    // decompiled from Move bytecode v6
}

