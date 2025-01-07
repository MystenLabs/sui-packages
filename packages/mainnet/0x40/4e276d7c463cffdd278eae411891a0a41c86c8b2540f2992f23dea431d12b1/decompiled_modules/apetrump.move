module 0x404e276d7c463cffdd278eae411891a0a41c86c8b2540f2992f23dea431d12b1::apetrump {
    struct APETRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: APETRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APETRUMP>(arg0, 6, b"APETRUMP", b"Apetrump", b"O o o o - APE 4 PRESIDENT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TRUMP_bdafbe53ff.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APETRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APETRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

