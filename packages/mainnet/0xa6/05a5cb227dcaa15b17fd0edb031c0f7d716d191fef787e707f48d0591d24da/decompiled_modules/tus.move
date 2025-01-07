module 0xa605a5cb227dcaa15b17fd0edb031c0f7d716d191fef787e707f48d0591d24da::tus {
    struct TUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUS>(arg0, 6, b"TUS", b"Tusko sui", b"Tusko sui tus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/29ctl_V1_F_Jo_TN_Ku3_C_Ux128lpp_Jpw_7549433b28.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

