module 0x2be7c89aa4ee3f5eec3135097d8674950f37c5304aa3f7bda0dd563f21d17555::SU {
    struct SU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SU>(arg0, 9, b"SU", b"SU", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SU>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SU>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<SU>>(0x2::coin::mint<SU>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

