module 0xaecc98bfb4bee0ea89b0b97432e68e495fe450904f22153221488748e750ec1d::shibashark {
    struct SHIBASHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIBASHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIBASHARK>(arg0, 6, b"ShibaShark", b"Shiba Shark", x"536869626120536861726b20546f6b656e2069732061206d656d652d62617365642063727970746f63757272656e637920636f6d62696e696e672074686520706c617966756c20737069726974206f6620536869626120496e7520776974682074686520626f6c646e657373206f66206120736861726b2e2049742773206275696c7420666f722066756e2c20636f6d6d756e6974792c20616e64206d6f6f6e206d697373696f6e73210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmbp_J_Rwwfo4_Bi4k_P3q_M_Yhg_Tcm1_Z_Nsu_T_Va_SC_Vukt_Epg_E5ve_8fcad06d5e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBASHARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIBASHARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

