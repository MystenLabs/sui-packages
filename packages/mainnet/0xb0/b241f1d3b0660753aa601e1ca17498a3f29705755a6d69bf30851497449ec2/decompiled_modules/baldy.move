module 0xb0b241f1d3b0660753aa601e1ca17498a3f29705755a6d69bf30851497449ec2::baldy {
    struct BALDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALDY>(arg0, 6, b"BALDY", b"Baldy", b"Sui BALDY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000038299_bb47dbf7bd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BALDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

