module 0x5aed490c2e26e69c52019cc12fdbbcfee54e55adfbab466c369a04e97f8ac7e9::fffff {
    struct FFFFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFFFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FFFFF>(arg0, 6, b"FFFFF", b"dd", b"gggg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_38_14aa5737ae.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFFFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FFFFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

