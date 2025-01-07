module 0x4513a0862a007771ec387334703998a31dc721d8137975df4c764b84bb4eeeef::mil {
    struct MIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIL>(arg0, 6, b"Mil", b"Mellion", b"Mellion is my cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730953329664.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

