module 0x9be3c307ebbd7c40535fd5241418c8367de53167ebd671b241009c0912b85cfc::gtt {
    struct GTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GTT>(arg0, 9, b"GTT", b"GiangThen", b"GTT TO THE MOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7ba37d24-83ad-4f27-a17a-24535991e5cf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

