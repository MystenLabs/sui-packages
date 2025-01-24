module 0x894b1d67d8675ca795f57bb91268f8688944fd417ad518703b0971fbd43b4236::ARM {
    struct ARM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARM>(arg0, 9, b"ARM", b"ARM", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ARM>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ARM>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<ARM>>(0x2::coin::mint<ARM>(&mut v2, 1100000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

