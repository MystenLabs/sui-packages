module 0x8679cf23ef93442f0ef8e6a69a6dc2873a9f3ac708d0d58220d0237ca50aa0e9::aixsui {
    struct AIXSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIXSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIXSUI>(arg0, 6, b"AIXSUI", b"Aixsui", b"$aixsui tracks Sui ecosystem discussions and leverages its proprietary AI engine to identify high-growth opportunities within the network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DR_7_Hmwj_T_400x400_f5854f3746.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIXSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIXSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

