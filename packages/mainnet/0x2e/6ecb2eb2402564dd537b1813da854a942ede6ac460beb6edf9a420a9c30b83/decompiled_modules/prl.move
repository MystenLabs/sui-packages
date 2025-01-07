module 0x2e6ecb2eb2402564dd537b1813da854a942ede6ac460beb6edf9a420a9c30b83::prl {
    struct PRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRL>(arg0, 8, b"PRL", b"Pearl", b"GEM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"0x813db0bae9aa83f5519155a0ef7225dce4198a55a626a1b56bac941d4c85182c")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PRL>(&mut v2, 70000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRL>>(v1);
    }

    // decompiled from Move bytecode v6
}

