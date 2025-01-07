module 0x70a426022ffa9770e3a00542fb20cb3df669b947c8bfe6caf5e998cdb0527a0b::bobbykertanegara {
    struct BOBBYKERTANEGARA has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BOBBYKERTANEGARA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BOBBYKERTANEGARA>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: BOBBYKERTANEGARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BOBBYKERTANEGARA>(arg0, 9, b"BOBBY", b"Bobby Kertanegara The Cat", x"426f626279204b657274616e65676172612074686520436174206f6e20537569206973206120636f6f6c2c20736f70686973746963617465642066656c696e652077697468206120686561727420666f7220616476656e7475726520616e6420612072657075746174696f6e2061732074686520e2809c63727970746f206b696e67206f6620637572696f7369747921e2809d20576974682068697320736c65656b206675722c20676f6c64656e20657965732c20616e642061207374796c697368206c6974746c652068617420746861742067697665732068696d206120666c616972206f66206d7973746572792c20426f62627920726f616d732074686520626c6f636b636861696e206c696b65206120736561736f6e6564206578706c6f7265722e204b6e6f776e20666f722068697320636861726d20616e64206b65656e2065796520666f72206469676974616c207472656173757265732c206865e2809973206f6e2061206d697373696f6e20746f2068656c702068697320667269656e6473206e61766967617465205375692077697468207374796c652c2067726163652c20616e64206a75737420612068696e74206f6620736173732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<BOBBYKERTANEGARA>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOBBYKERTANEGARA>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBBYKERTANEGARA>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BOBBYKERTANEGARA>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BOBBYKERTANEGARA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<BOBBYKERTANEGARA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

