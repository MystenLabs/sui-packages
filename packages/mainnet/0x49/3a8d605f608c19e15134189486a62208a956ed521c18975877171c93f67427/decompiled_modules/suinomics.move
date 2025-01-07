module 0x493a8d605f608c19e15134189486a62208a956ed521c18975877171c93f67427::suinomics {
    struct SUINOMICS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINOMICS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINOMICS>(arg0, 6, b"SUINOMICS", b"SUINOMICS - SUI ECONOMICS", b"SUINOMICS - Is the new generation of economics", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Leonardo_Phoenix_A_vibrant_2_D_digital_illustration_of_cartoon_0_8f4a1d01f9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINOMICS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINOMICS>>(v1);
    }

    // decompiled from Move bytecode v6
}

