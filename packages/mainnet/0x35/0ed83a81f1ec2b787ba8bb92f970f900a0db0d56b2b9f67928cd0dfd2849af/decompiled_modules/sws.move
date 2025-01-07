module 0x350ed83a81f1ec2b787ba8bb92f970f900a0db0d56b2b9f67928cd0dfd2849af::sws {
    struct SWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWS>(arg0, 8, b"SWS", b"SwordfishSilly", b"buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJvuhlSqx3h_SlqEF1aTzjOKeJ9WS_jf0ZQx4wQxr21f6W4Ue-2ZS8KL2PLA&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SWS>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

