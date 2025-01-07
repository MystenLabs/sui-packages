module 0xdd2d6e4af785a7f6d040c2b999be28a1d817afffb46cf43f249c8da1170da844::gtt {
    struct GTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GTT>(arg0, 9, b"GTT", b"GiangThen", b"GTT TO THE MOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c1986759-243f-4d3a-9cde-41b32fa5f419.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

