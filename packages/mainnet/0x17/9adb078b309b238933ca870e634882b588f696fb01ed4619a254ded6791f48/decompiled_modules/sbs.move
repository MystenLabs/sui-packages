module 0x179adb078b309b238933ca870e634882b588f696fb01ed4619a254ded6791f48::sbs {
    struct SBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBS>(arg0, 6, b"SBS", b"Sui Bull Shark", b"Only Shark only can say \"Bull Bull Bull Shark on SUI\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/carddizzy_f4c09654_a8536dc77c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

