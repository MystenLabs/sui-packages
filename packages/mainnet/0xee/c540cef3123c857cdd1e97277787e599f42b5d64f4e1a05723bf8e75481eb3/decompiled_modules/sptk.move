module 0xeec540cef3123c857cdd1e97277787e599f42b5d64f4e1a05723bf8e75481eb3::sptk {
    struct SPTK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPTK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPTK>(arg0, 6, b"SPTK", b"SepthikTank", b"Sha Pho Ta Ka  of Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_20241016_230327_1_fd6553dd71.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPTK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPTK>>(v1);
    }

    // decompiled from Move bytecode v6
}

