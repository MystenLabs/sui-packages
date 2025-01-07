module 0xe22b23fd64a0498154645a033d26b5c65e25befe2de14aa5991625c1b8ee99a8::GIRLS {
    struct GIRLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIRLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIRLS>(arg0, 9, b"GIRLS", b"GIRLS", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GIRLS>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GIRLS>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<GIRLS>>(0x2::coin::mint<GIRLS>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

