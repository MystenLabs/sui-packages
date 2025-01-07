module 0xdb3d1488aff0979d35e08e9662f4cc1113b261862d00e3090a167685feab7163::binks {
    struct BINKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BINKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BINKS>(arg0, 6, b"BINKS", b"BINKS On Sui", x"4275696c64696e67207468652077616c727573206f6620636f6d70757465206f6e200a407375696e6574776f726b0a0a5265647563696e6720636f7374206f6620636f6d7075746520627920313030307820616e64207468757320616c6c6f77696e67206e657720757365206361736520696d706f737369626c65206265666f7265", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/t_B_Rh_F_Ef_C_400x400_e27851c00f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BINKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BINKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

