module 0x905a752675918c8f15a6aef814a1e9ce154c8ba0ee3bbb11e4bc785830b65c18::smem {
    struct SMEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMEM>(arg0, 6, b"SMEM", b"SUI MEMTANA", x"205452454e44494e4720544f5020496e737069726564206279204a757374696e2053756e73206661766f72697465206d6f7669652c2053636172666163652c20535549204d656d74616e61206973206120626f6c6420616e6420666561726c657373206d656d65636f696e206f6e207468652053554920626c6f636b636861696e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TRMEM_T_Arofm_r5p_MO_Sgg8_Sb_U_1_1b3e08366f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

