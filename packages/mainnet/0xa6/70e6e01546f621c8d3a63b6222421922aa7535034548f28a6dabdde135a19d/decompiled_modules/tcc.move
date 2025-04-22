module 0xa670e6e01546f621c8d3a63b6222421922aa7535034548f28a6dabdde135a19d::tcc {
    struct TCC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TCC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TCC>(arg0, 6, b"TCC", b"token test", b"test token c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2025_04_22_at_16_12_21_e042db95ab.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TCC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TCC>>(v1);
    }

    // decompiled from Move bytecode v6
}

