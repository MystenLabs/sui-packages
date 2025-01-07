module 0x568063198a11f17c51fa5504ae74d0baf4cb4b34eb332f2f1b0959ebb74ff612::ginnan {
    struct GINNAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GINNAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GINNAN>(arg0, 6, b"GINNAN", b"GINNAN ON SUI", b"$GINNAN is ready to take over as the baddest cat Roaring Kitty thinks so.. Come Join a community! ginnancatcoin.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/maho_1eb46cca22.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GINNAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GINNAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

