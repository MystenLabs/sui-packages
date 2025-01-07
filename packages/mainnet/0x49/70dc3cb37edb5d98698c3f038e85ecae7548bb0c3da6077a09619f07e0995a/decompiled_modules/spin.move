module 0x4970dc3cb37edb5d98698c3f038e85ecae7548bb0c3da6077a09619f07e0995a::spin {
    struct SPIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPIN>(arg0, 6, b"SPIN", b"SUISpin", b"Suispin.casino is the ultimate web3 casino on SUI. Spin and Win while enjoying fast payouts total anonymity and provably fair gaming experience.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suispin_logo_ed165675bb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

