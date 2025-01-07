module 0x84748cea8b87f291064f4f0365210997aaa2132339d846e427310b7a0981c781::dckt {
    struct DCKT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DCKT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DCKT>(arg0, 6, b"DCKT", b"Ducketeers", b"Join the flock!  #Ducketeers #Memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_12_09_at_6_23_44a_PM_a753d83ee6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DCKT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DCKT>>(v1);
    }

    // decompiled from Move bytecode v6
}

