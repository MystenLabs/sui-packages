module 0x55b3bff34664f08b5feb2fec7f5fb199c2016b7700383e75ab8b43008afe109a::tlr {
    struct TLR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TLR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TLR>(arg0, 6, b"TLR", b"Tyler SUI", b"Tyler is the fictional legendary character from Fatt Murie's Guys' Club comic. He is also a dancer and loves video games just as much as $BRETT.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/floating_cloud_6341493f60.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TLR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TLR>>(v1);
    }

    // decompiled from Move bytecode v6
}

