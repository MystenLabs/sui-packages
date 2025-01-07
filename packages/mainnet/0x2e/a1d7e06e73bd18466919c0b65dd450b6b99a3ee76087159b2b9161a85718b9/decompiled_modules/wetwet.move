module 0x2ea1d7e06e73bd18466919c0b65dd450b6b99a3ee76087159b2b9161a85718b9::wetwet {
    struct WETWET has drop {
        dummy_field: bool,
    }

    fun init(arg0: WETWET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WETWET>(arg0, 6, b"WETWET", b"SMUG FACE EMOJI", x"4974206973206e6f742073776561742c2069747320776574776574210a477261622057455457455420736d69726b696e6720736d756720666163652e2057652077696c6c206d616b6520616e204e465420636f6c6c656374696f6e20666f72207468697320736f6f6e2e0a0a4e6f7420616666696c6961746564207769746820616e796f6e652e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/IMG_20240925_010757_863_2fd1b23ccb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WETWET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WETWET>>(v1);
    }

    // decompiled from Move bytecode v6
}

