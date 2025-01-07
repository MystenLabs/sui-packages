module 0x726e3fa789a935229c85b94c04160a18c1b549540aeae2cf3baba198ba7e7e74::sleep {
    struct SLEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLEEP>(arg0, 6, b"Sleep", b"Going to sleep", x"4a7573742077616e7420746f2062757920736f6d657468696e672074686174206973206e6f742061207363616d206265666f726520676f696e6720746f206265642e0a446f207768617420796f752077616e74204920646f6e2774206361726520492077696c6c2062652061736c6565702e0a476f6f646e69676874", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bed_76781ec55d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLEEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLEEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

