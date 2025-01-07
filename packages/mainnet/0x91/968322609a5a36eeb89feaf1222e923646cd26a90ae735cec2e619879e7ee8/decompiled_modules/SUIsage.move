module 0x91968322609a5a36eeb89feaf1222e923646cd26a90ae735cec2e619879e7ee8::SUIsage {
    struct SUISAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISAGE>(arg0, 9, b"SUISAGE", b"SUIsage", b"SUIsage - grab a sausage. LP tokens - burned, Smartcontract - immutable.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeibipvssimyi2vqxgepkfelgvgowee4gr47dmzq3bmfoxs2xeav6vi.ipfs.nftstorage.link/vkbw399qhe.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISAGE>>(v1);
        0x2::coin::mint_and_transfer<SUISAGE>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISAGE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

