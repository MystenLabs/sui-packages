module 0x472772dc900770fa07b6ed9567afd95df516a57f79679fb85481976a7d78c3d1::dawg {
    struct DAWG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAWG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAWG>(arg0, 6, b"DAWG", b"DAWGG", x"4920616d20746865206f6e6520616e64206f6e6c792053756920444157472120f09f90b6f09f92a52047657420726561647920666f722061206a6f75726e6579206c696b65206e6f206f7468657220696e2074686520776f726c64206f662063727970746f2e20f09f8c8de29ca8204c6574e2809973206d616b6520776176657320746f67657468657220776974682024444157472120f09f8c8af09f9a80f09f92b00a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731034262034.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAWG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAWG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

