module 0xc5b47dedc97cf3201a34748abfe51a9c221d1135068786eafd0413c259cfe08d::SUN {
    struct SUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUN>(arg0, 9, b"SUN", b"SUN", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUN>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUN>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUN>>(0x2::coin::mint<SUN>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

