module 0x99197e93d30f2833c057ddc0d65acf393caa05bfcece20ae453d6f07350b74af::dif {
    struct DIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIF>(arg0, 6, b"DIF", b"DevIsFish", b"THE DEV IS FISH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000608_eae8304383.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

