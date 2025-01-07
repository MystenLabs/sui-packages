module 0x41be96b5b9918792b8fd6ac062cd7d6456f64b0eb768548943c14e1422297e18::dtc {
    struct DTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DTC>(arg0, 6, b"DTC", b"Doge Trump Coin", b"Doge Trump Coin (DTC) is a fresh and satirical memecoin blending the iconic Shiba Inu from Dogecoin with a bold personality inspired by Donald Trump. Representing strength, confidence, and \"bigger-than-life\" ambitions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732094892445.34")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DTC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DTC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

