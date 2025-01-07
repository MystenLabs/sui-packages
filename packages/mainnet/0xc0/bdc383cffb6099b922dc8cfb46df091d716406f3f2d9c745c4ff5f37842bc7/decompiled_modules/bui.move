module 0xc0bdc383cffb6099b922dc8cfb46df091d716406f3f2d9c745c4ff5f37842bc7::bui {
    struct BUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUI>(arg0, 6, b"BUI", b"BUU COIN ON SUI", b"BUU COIN WILL BE THE NEXT MILLIONS CAP ON SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736039366144.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

