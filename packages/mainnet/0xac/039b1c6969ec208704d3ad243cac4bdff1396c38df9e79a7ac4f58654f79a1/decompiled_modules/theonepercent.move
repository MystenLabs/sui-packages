module 0xac039b1c6969ec208704d3ad243cac4bdff1396c38df9e79a7ac4f58654f79a1::theonepercent {
    struct THEONEPERCENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: THEONEPERCENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THEONEPERCENT>(arg0, 6, b"TheOnePercent", b"1%", b"The One Percent on SUI.. Original dev was part of the 99% and tried to fuck with the 1. We will show him how its done.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3za_G_Is5_N_f78926195b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THEONEPERCENT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THEONEPERCENT>>(v1);
    }

    // decompiled from Move bytecode v6
}

