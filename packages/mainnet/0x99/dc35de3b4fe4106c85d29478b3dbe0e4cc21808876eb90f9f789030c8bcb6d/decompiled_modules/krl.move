module 0x99dc35de3b4fe4106c85d29478b3dbe0e4cc21808876eb90f9f789030c8bcb6d::krl {
    struct KRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRL>(arg0, 9, b"KRL", b"Krilin", b"KRILIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/91d05c12-d80c-48ef-aea9-b6b62bf4f1bd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRL>>(v1);
    }

    // decompiled from Move bytecode v6
}

