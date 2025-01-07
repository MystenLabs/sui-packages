module 0x73b13ef5c4153b6ea01cf988b706aa0fd29a8208eada1caebd170c4cde9225b1::iotato {
    struct IOTATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: IOTATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IOTATO>(arg0, 6, b"IOTATO", b"Sui Iotato", b"Iotato memecoin on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000015345_ce3d0ad24a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IOTATO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IOTATO>>(v1);
    }

    // decompiled from Move bytecode v6
}

