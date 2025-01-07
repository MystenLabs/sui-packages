module 0xe30a980f1f15b356d1532bf124746b3a6f0a2e3b8c84504698568294431a37f9::BOYS {
    struct BOYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOYS>(arg0, 9, b"BOYS", b"BOYS", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOYS>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BOYS>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<BOYS>>(0x2::coin::mint<BOYS>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

