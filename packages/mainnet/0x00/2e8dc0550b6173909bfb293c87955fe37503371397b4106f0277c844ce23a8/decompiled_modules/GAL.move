module 0x2e8dc0550b6173909bfb293c87955fe37503371397b4106f0277c844ce23a8::GAL {
    struct GAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAL>(arg0, 9, b"GAL", b"GAL", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GAL>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GAL>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<GAL>>(0x2::coin::mint<GAL>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

