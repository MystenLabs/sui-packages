module 0x492b530fe7022c520222c4c5ae86dcdb81197a02f8f23745b1714b5ed6a2f108::clm {
    struct CLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLM>(arg0, 6, b"CLM", b"CALM", b"I breathe, click, and calm down, I breathe, click, and calm down, I breathe, click, and calm down!In the end I will smile.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d18da0e4_6f42_461e_95e1_f76cf894f79f_754x394_78cef9c415.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLM>>(v1);
    }

    // decompiled from Move bytecode v6
}

