module 0x8bd7d6aae3ad333b26001862959faefda8abc3b7ce8a1650622ebd075250cbcd::gloo {
    struct GLOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLOO>(arg0, 6, b"GLOO", b"Gloo Sui", b"Be Gloo, be Bloo. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735929314299.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GLOO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLOO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

