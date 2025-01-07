module 0x946a6ee315406d2795a3eee3412eda8b3f11de4382cd42a140c1ac6f89483520::ckn {
    struct CKN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CKN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CKN>(arg0, 9, b"CKN", b"Chicken", b"Chicken chicken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9d794c83-768a-449f-a78f-b1ec2aa6aa64.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CKN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CKN>>(v1);
    }

    // decompiled from Move bytecode v6
}

