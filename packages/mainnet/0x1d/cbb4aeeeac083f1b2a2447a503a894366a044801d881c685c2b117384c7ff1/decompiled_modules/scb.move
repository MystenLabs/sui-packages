module 0x1dcbb4aeeeac083f1b2a2447a503a894366a044801d881c685c2b117384c7ff1::scb {
    struct SCB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCB>(arg0, 6, b"SCB", b"Sacabam", x"5361636162616d206973204f47206d656d6520234275696c644f6e5375690a24534342206973206e6174697665206d656d65636f696e206f6e20235375696e6574776f726b20245355490a5669736974206f7572204d656d45636f73797374656d2062656c6f77", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4tx_Wr_U_Ng_400x400_6797b19338.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCB>>(v1);
    }

    // decompiled from Move bytecode v6
}

