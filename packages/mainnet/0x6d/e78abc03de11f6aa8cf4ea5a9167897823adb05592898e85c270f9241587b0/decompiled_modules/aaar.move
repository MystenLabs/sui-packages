module 0x6de78abc03de11f6aa8cf4ea5a9167897823adb05592898e85c270f9241587b0::aaar {
    struct AAAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAR>(arg0, 6, b"AAAR", b"AAAARAT ON SUI", b"Can't stop won't stop (thinking about Sui)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0_a99a5b25f0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

