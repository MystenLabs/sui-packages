module 0x7c7ba7f8fdf23a69249902971337635f79ed81040df40c77c5a38e2e53b5db10::JHP {
    struct JHP has drop {
        dummy_field: bool,
    }

    fun init(arg0: JHP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JHP>(arg0, 9, b"JHP", b"JHP", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JHP>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<JHP>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<JHP>>(0x2::coin::mint<JHP>(&mut v2, 1100000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

