module 0xd99239ab80a464634fba5f29cf7803a6544b6aae7c8ab19bb027514c5e23ff74::dgo {
    struct DGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGO>(arg0, 9, b"DGO", b"Drogo", x"447261676f6ee280997320666174686572", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5c615010-15b4-4011-b04a-00f0afeae8f7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

