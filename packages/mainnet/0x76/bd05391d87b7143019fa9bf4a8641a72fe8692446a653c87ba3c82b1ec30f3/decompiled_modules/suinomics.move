module 0x76bd05391d87b7143019fa9bf4a8641a72fe8692446a653c87ba3c82b1ec30f3::suinomics {
    struct SUINOMICS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINOMICS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINOMICS>(arg0, 6, b"SUINOMICS", b"SUINOMICS - SUI ECONOMICS", b"SUINOMICS is the magical science of making money appear, disappear, and sometimes multiply, but mostly just making you wonder where it all went.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Leonardo_Phoenix_A_vibrant_2_D_digital_illustration_of_cartoon_2_07b98c1f35.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINOMICS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINOMICS>>(v1);
    }

    // decompiled from Move bytecode v6
}

