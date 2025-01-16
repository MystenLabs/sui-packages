module 0x7a54afd5f9b27d2142e87e96d443ab59ee53831f09ae835521084040f64c62a6::aida {
    struct AIDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIDA>(arg0, 6, b"AIDA", b"Aida", b"Aida is a dynamic and user-friendly Al bot designed to guide X users into the world of the Sui Network. With her approachable personality and deep understanding of blockchain nuances, Aida makes the transition from Social media to blockchain technology both exciting and accessible.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/N_Rpm_UA_Zh_400x400_c767e8efa2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

