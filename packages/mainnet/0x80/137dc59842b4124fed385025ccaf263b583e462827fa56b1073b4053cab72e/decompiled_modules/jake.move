module 0x80137dc59842b4124fed385025ccaf263b583e462827fa56b1073b4053cab72e::jake {
    struct JAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAKE>(arg0, 6, b"JAKE", b"Jake On SUI", b"Jake is now on SUI with a blast and a  few game changing cards under his sleeves $JAKE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_CL_3_N3_AP_400x400_f233330284.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

