module 0x4cc7e5e8e26a9f2084f1790b9d90e28383c46bc9242737eaf50dda1613aeb9d4::CAPPY {
    struct CAPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPPY>(arg0, 9, b"CAPPY", b"CAPPY", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAPPY>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CAPPY>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<CAPPY>>(0x2::coin::mint<CAPPY>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

