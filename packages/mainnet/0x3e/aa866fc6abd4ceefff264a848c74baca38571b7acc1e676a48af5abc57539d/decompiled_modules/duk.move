module 0x3eaa866fc6abd4ceefff264a848c74baca38571b7acc1e676a48af5abc57539d::duk {
    struct DUK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUK>(arg0, 9, b"DUK", b"Scream Duk", b"Just a screaming Duk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d97b1dd1-a734-4bca-8a8c-204bb8ec66d6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUK>>(v1);
    }

    // decompiled from Move bytecode v6
}

