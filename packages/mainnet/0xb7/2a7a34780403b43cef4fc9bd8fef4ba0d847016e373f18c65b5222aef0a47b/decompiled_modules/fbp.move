module 0xb72a7a34780403b43cef4fc9bd8fef4ba0d847016e373f18c65b5222aef0a47b::fbp {
    struct FBP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FBP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FBP>(arg0, 6, b"FBP", b"First Bitcoin Price", x"666972737420626974636f696e2070726963652024302e30360a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Z_Tf6c63y2_Nrgr_DL_Cq_Ero37_D_Ra_C14k_Txs_K66nq_C_Wqx8q_H_0b06ee0495.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FBP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FBP>>(v1);
    }

    // decompiled from Move bytecode v6
}

