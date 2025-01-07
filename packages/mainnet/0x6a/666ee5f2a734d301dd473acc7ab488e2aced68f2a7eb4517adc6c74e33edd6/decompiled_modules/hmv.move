module 0x6a666ee5f2a734d301dd473acc7ab488e2aced68f2a7eb4517adc6c74e33edd6::hmv {
    struct HMV has drop {
        dummy_field: bool,
    }

    fun init(arg0: HMV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HMV>(arg0, 6, b"HMV", b"Hidden Mist Village", b"Kirigakure is the hidden village of the Land of Water.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/HMV_10fb24fc85.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HMV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HMV>>(v1);
    }

    // decompiled from Move bytecode v6
}

