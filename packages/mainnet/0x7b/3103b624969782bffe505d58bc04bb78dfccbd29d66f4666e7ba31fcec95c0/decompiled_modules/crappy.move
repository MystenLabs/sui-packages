module 0x7b3103b624969782bffe505d58bc04bb78dfccbd29d66f4666e7ba31fcec95c0::crappy {
    struct CRAPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRAPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRAPPY>(arg0, 6, b"CRAPPY", b"First Crappy Bird On Sui", b"First crappy  bird on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_1_27_f17a7006d4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRAPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRAPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

