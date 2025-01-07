module 0xd8b00403a514f99d72596e35b6ed48a35db10b9967a800a8f5ecae5275f0a432::chu {
    struct CHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHU>(arg0, 6, b"CHU", b"chui", x"746865206269672070696e6b207261626269740a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmb_Gf_U_Tyj_Dju7wd_NNQ_Vti_Tr5_E49x_M53ofi_Zm3z_Zrp_F_Kqm_K_573aac0095.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHU>>(v1);
    }

    // decompiled from Move bytecode v6
}

