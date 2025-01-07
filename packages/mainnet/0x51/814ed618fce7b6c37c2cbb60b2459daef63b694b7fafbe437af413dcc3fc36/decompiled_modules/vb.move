module 0x51814ed618fce7b6c37c2cbb60b2459daef63b694b7fafbe437af413dcc3fc36::vb {
    struct VB has drop {
        dummy_field: bool,
    }

    fun init(arg0: VB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VB>(arg0, 9, b"VB", b"Vibes ", b"Token created for those that love enjoyment ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4aac0a2b-e2b5-4a09-b493-a50068f30af5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VB>>(v1);
    }

    // decompiled from Move bytecode v6
}

