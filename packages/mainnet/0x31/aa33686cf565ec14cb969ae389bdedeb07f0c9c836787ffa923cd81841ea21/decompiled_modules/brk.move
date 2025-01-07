module 0x31aa33686cf565ec14cb969ae389bdedeb07f0c9c836787ffa923cd81841ea21::brk {
    struct BRK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRK>(arg0, 9, b"BRK", b"Berak", b"No desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/507d6f50-4890-49a3-9f74-9d0d69c5a772.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRK>>(v1);
    }

    // decompiled from Move bytecode v6
}

