module 0x55adba13354e7dc8d922dd7ae414fbc25567f589a9a28461c129e4b2ca364716::maunt {
    struct MAUNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAUNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAUNT>(arg0, 9, b"MAUNT", b"MAUNTAIN", b"THE MAUNTAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9da3afb7-9297-4756-b780-8f9ab6a8869b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAUNT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAUNT>>(v1);
    }

    // decompiled from Move bytecode v6
}

