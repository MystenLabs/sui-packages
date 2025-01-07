module 0xf92c9272312b3e46695cfe227eab8e18560b97c425e30343fc2ebea086574c29::ama {
    struct AMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMA>(arg0, 9, b"AMA", b"Amanita", b"Just a mushroom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/29f8ba41-64a6-4df5-ab9a-97b13998894a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

