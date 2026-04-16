module 0x888928248b9060b9d6b16a6ff3528704769b8195209ec22a6cf291534a9c7f58::flt999 {
    struct FLT999 has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<FLT999>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FLT999>>(0x2::coin::mint<FLT999>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: FLT999, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLT999>(arg0, 9, b"FLT999", b"FLOATING Notes", x"466c6f6174696e67204e6f74657320746f6b656e20e28094204669626f6e6163636920737570706c793a2032383635372e20496e737572616e63653a203130306270732e2058616861753a207270717a434b617656635a617971646d695251554b75367a347a33794b7376773956", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://zedec.io/tokens/flt999.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLT999>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLT999>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

