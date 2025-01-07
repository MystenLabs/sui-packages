module 0xdf68ff5394062a7f5752cc88a29eace21423fc757a961c81bea1c6fd73647569::bw {
    struct BW has drop {
        dummy_field: bool,
    }

    fun init(arg0: BW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BW>(arg0, 6, b"BW", b"Blue Wolf", b"Blue Wolf of Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000119_da33edf6e6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BW>>(v1);
    }

    // decompiled from Move bytecode v6
}

