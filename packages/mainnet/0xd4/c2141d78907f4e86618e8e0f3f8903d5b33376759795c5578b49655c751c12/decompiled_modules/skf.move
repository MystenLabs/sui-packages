module 0xd4c2141d78907f4e86618e8e0f3f8903d5b33376759795c5578b49655c751c12::skf {
    struct SKF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKF>(arg0, 9, b"SKF", b"Skuff", b"Skufidon fat man", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/19701ded-0b6d-4638-bafb-7d84bf24dcc9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKF>>(v1);
    }

    // decompiled from Move bytecode v6
}

