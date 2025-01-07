module 0x6bb6e186c36c13259cc8e1de3a2630113f28cbb7da7dae6efe4f0381dd272e48::mongy {
    struct MONGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONGY>(arg0, 6, b"MONGY", b"MONGY SUI", b"MONGY  ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6o_R7wc_MN_400x400_7652346f1f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

