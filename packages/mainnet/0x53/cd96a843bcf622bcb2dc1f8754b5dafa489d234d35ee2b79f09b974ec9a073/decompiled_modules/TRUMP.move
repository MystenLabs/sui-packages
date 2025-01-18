module 0x53cd96a843bcf622bcb2dc1f8754b5dafa489d234d35ee2b79f09b974ec9a073::TRUMP {
    struct TRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP>(arg0, 9, b"TRUMP", b"TRUMP", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMP>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TRUMP>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<TRUMP>>(0x2::coin::mint<TRUMP>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

