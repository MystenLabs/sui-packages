module 0x122ec69e8ea81a3cfe9afa99f7d22ccd0e40ec49e084832abafd3fb780d3ebc0::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0443524142104b696e672043726162206f6e20537569b1014b696e67204372616220697320746865206c6f6e67207465726d20636f6f6b206f6e20245355492077652077696c6c206e6f742073746f7020637261776c696e67206163726f737320796f75722074696d656c696e652e20436865636b206f7574206f7572204c696e6b205472656520666f722074686520696e666f20796f75206e656564217c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f4b696e67437261626f6e737569227d4d68747470733a2f2f7062732e7477696d672e636f6d2f70726f66696c655f696d616765732f323030383532313832323635373030373631362f5a6f4c51334b45475f343030783430302e6a7067");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

