module 0x9ed007d054be4039febdfbe33abb04ed40582234d36cb9134b6f4378c7ffa4cc::jc {
    struct JC has drop {
        dummy_field: bool,
    }

    fun init(arg0: JC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JC>(arg0, 9, b"JC", b"JC", b"JCJENSON IN SPAAACE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://imgdlvr.com/pic/photoresizer.com/20240601-5406/public")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JC>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JC>>(v2, @0xad25747cd381b38b0c1da529ab78971aa6e7e18ac7f8ed18648d9077130aab9f);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JC>>(v1);
    }

    // decompiled from Move bytecode v6
}

