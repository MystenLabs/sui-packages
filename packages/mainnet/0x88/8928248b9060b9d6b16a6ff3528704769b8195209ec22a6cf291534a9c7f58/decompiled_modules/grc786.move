module 0x888928248b9060b9d6b16a6ff3528704769b8195209ec22a6cf291534a9c7f58::grc786 {
    struct GRC786 has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<GRC786>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GRC786>>(0x2::coin::mint<GRC786>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: GRC786, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRC786>(arg0, 9, b"GRC786", b"GRACE", x"477261636520746f6b656e20e28094204669626f6e6163636920737570706c793a20343138312e20496e737572616e63653a203130306270732e2058616861753a2072666b786369644c52666a705041566a4e7364634a7a42394a5158484b764b743532", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://zedec.io/tokens/grc786.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRC786>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRC786>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

