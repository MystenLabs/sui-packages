module 0x64324c76af89feeb08200f0b18625cfc5ec6b3dd5ad9602ce3c625f77ebee6c8::queen {
    struct QUEEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUEEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUEEN>(arg0, 6, b"QUEEN", b"MCQUEEN", b"The first mascot car on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/red_car_main_80b067ad66.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUEEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QUEEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

