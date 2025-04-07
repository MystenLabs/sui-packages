module 0x14f0de15fef379474b8f306ae286f49d32fc804a81e5d4335d6f671172f105b4::bamm {
    struct BAMM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAMM>(arg0, 6, b"Bamm", b"Bye", b"heio", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/f3db6a32_9923_4a7a_9a75_05cfdf5c32d1_eef2803205.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAMM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAMM>>(v1);
    }

    // decompiled from Move bytecode v6
}

