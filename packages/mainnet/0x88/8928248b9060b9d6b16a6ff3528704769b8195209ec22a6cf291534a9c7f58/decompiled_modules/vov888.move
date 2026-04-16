module 0x888928248b9060b9d6b16a6ff3528704769b8195209ec22a6cf291534a9c7f58::vov888 {
    struct VOV888 has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<VOV888>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<VOV888>>(0x2::coin::mint<VOV888>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: VOV888, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VOV888>(arg0, 9, b"VOV888", b"VOVINA", x"564f56494e4120746f6b656e20e28094204669626f6e6163636920737570706c793a2031373731312e20496e737572616e63653a203130306270732e2058616861753a207248446e4b46526f56796f417670563752376a4e34334e324666624a6d5476795771", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://zedec.io/tokens/vov888.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VOV888>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VOV888>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

