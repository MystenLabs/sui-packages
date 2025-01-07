module 0x29e23811652925bb2a890a34fb89cc7c55bba9d66842f958f0542d665e93ce98::ppay {
    struct PPAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPAY>(arg0, 6, b"PPAY", b"Pepe's Payday", b"Pepe pulled the ultimate heist: robbed ETH and sprinted to SUI with all the cash.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pepe_97653e3f12.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PPAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

