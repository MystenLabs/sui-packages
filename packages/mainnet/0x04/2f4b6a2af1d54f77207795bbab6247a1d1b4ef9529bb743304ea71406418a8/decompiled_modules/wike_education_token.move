module 0x42f4b6a2af1d54f77207795bbab6247a1d1b4ef9529bb743304ea71406418a8::wike_education_token {
    struct WIKE_EDUCATION_TOKEN has drop {
        dummy_field: bool,
    }

    public entry fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<WIKE_EDUCATION_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WIKE_EDUCATION_TOKEN>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: WIKE_EDUCATION_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 688 || 0x2::tx_context::epoch(arg1) == 689, 1);
        let (v0, v1) = 0x2::coin::create_currency<WIKE_EDUCATION_TOKEN>(arg0, 9, b"WT", b"Wike Education Token", x"57696b6920456475636174696f6e2047726f757020697320612022736f6369616c2062656e656669742220666f722d70726f66697420636f6d70616e792028534f4349414c2042454e4546495420434f5250292e2047726f7570204d697373696f6e3a20546f20726567617264202257696b6970656469612220617320746865206d6f73742076616c7561626c6520226b6e6f776c656467652064617461626173652220696e2074686520414920e2808be2808b6572612c20616e6420746f20656e61626c652074686520414920e2808be2808b4c61726765204c616e6775616765204d6f64656c20284c4c4d2920746f2068617665207265616c206c6f676963616c207468696e6b696e67206162696c697479207468726f7567682074686520616c676f726974686d206f662073656d616e746963206c696e6b732e2020207777772e77696b6567726f75702e636f6d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://bafkreibhq5pbyppgawg235utytysgpnojcs3ijw5gdlaoptjlsq3f64ony.ipfs.w3s.link/"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WIKE_EDUCATION_TOKEN>(&mut v2, 10000000000000000000, @0x7028f15cfed056cf107659ace93cc2683c18bc291427af983bd84dff5083e6df, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIKE_EDUCATION_TOKEN>>(v2, @0x7028f15cfed056cf107659ace93cc2683c18bc291427af983bd84dff5083e6df);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WIKE_EDUCATION_TOKEN>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun revoke_metadata(arg0: 0x2::coin::CoinMetadata<WIKE_EDUCATION_TOKEN>) {
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WIKE_EDUCATION_TOKEN>>(arg0);
    }

    public entry fun update_metadata(arg0: &mut 0x2::coin::TreasuryCap<WIKE_EDUCATION_TOKEN>, arg1: &mut 0x2::coin::CoinMetadata<WIKE_EDUCATION_TOKEN>, arg2: 0x1::string::String, arg3: 0x1::ascii::String, arg4: 0x1::string::String, arg5: 0x1::ascii::String) {
        0x2::coin::update_name<WIKE_EDUCATION_TOKEN>(arg0, arg1, arg2);
        0x2::coin::update_symbol<WIKE_EDUCATION_TOKEN>(arg0, arg1, arg3);
        0x2::coin::update_description<WIKE_EDUCATION_TOKEN>(arg0, arg1, arg4);
        0x2::coin::update_icon_url<WIKE_EDUCATION_TOKEN>(arg0, arg1, arg5);
    }

    // decompiled from Move bytecode v6
}

