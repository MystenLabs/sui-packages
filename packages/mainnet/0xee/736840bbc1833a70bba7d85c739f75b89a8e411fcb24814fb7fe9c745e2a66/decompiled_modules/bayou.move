module 0xee736840bbc1833a70bba7d85c739f75b89a8e411fcb24814fb7fe9c745e2a66::bayou {
    struct BAYOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAYOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAYOU>(arg0, 6, b"Bayou", b"Bayou Ninja", b"Bayou Ninja  X official Account : @bayouninjaonsui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fnan_GQ_6a_EA_Ap_Hn_X_56ebe4ec56.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAYOU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAYOU>>(v1);
    }

    // decompiled from Move bytecode v6
}

