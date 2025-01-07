module 0x5275b89717ef0f454b64e892c7c946b6aa3414a8500aebafbac5c71e922a8407::zyz {
    struct ZYZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZYZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZYZ>(arg0, 9, b"ZYZ", b"Zyzy", b"Nice", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0073102d-7b74-4e7f-b04e-4741c0f129d4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZYZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZYZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

