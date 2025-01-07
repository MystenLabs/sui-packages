module 0x6e7c7af603280ecc2192f37abe4aa5f0fe26541be903bcccd5494a123d82c609::bloom {
    struct BLOOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOOM>(arg0, 6, b"BLOOM", b"BLOOMSUI", x"4120736d616c6c206265616e2077697468206269672061737069726174696f6e73212047726f77696e6720610a7468726976696e6720636f6d6d756e6974792077697468696e20746865207375692065636f73797374656d2c0a6861726e657373696e672074686520706f776572206f66206d656d657320616e6420766972616c206d6f6d656e74730a746f20736f617220746f206e657720686569676874732e204c657473207269736520746f676574686572", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/avatarrr_acda5dc78d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

