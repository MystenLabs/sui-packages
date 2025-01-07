module 0xa8722f9e83d0b2298b67fdb9038b157f19165ecf4700f953ca83adcce2e5d4f5::onx {
    struct ONX has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONX>(arg0, 9, b"ONX", b"Onus", b"Except the growth in the crypto space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5b135884-1ae3-4a60-91a1-fa9aa012e59e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ONX>>(v1);
    }

    // decompiled from Move bytecode v6
}

