module 0x4a07a1680793d2f8f7c73267200bbdf02dd86f8773c4436827ea2199b1526bc1::cfp {
    struct CFP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CFP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CFP>(arg0, 6, b"CFP", b"Cat Feeding Place", b"What if Uptober ended on a high note?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZ_8e_U_Rz_XEAMIQI_1_f873a22b5e.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CFP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CFP>>(v1);
    }

    // decompiled from Move bytecode v6
}

