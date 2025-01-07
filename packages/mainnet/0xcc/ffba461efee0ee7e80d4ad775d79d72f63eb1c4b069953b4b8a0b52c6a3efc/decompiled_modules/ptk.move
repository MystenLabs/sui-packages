module 0xccffba461efee0ee7e80d4ad775d79d72f63eb1c4b069953b4b8a0b52c6a3efc::ptk {
    struct PTK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTK>(arg0, 9, b"PTK", b"Puttotalk", b"Talk or silen", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6d77c101-e177-4e7c-843a-de82cb84afe0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PTK>>(v1);
    }

    // decompiled from Move bytecode v6
}

