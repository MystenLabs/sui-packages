module 0xeaa6738cd577027c2116b73d5d43da258a3ef873c1dcac8eca0f3f2353b31543::uponly {
    struct UPONLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: UPONLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UPONLY>(arg0, 6, b"UPONLY", b"UP ONLY", b"The First Official SUI Only Up Memcoin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003785_386c8086e9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UPONLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UPONLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

