module 0x127d54bd664700fcc61f62324e3d891a4661c70de8bc2ae94d989a27f4936f46::trt {
    struct TRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRT>(arg0, 6, b"TRT", b"Trump Replacement Therapy", b"Trump is here to provide $TRT for all those who are not prepared for his claim back to power. Not ready For trump back in the office? Unfortunately, therapy is the only way for some.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/ppp_1a07a5573d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRT>>(v1);
    }

    // decompiled from Move bytecode v6
}

