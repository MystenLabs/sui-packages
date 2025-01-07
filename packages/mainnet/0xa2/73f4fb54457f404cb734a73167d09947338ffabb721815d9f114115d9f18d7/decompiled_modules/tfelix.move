module 0xa273f4fb54457f404cb734a73167d09947338ffabb721815d9f114115d9f18d7::tfelix {
    struct TFELIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: TFELIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TFELIX>(arg0, 6, b"TFELIX", b"TURBO FELIX", b"Welcome to Turbo FELIX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730963899665.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TFELIX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TFELIX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

