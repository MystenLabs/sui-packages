module 0xfcb29f878b34cab8f65afc5cbd0df0d4dd81b384631ad0c9136d2d63a3a7c063::rte {
    struct RTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RTE>(arg0, 9, b"RTE", b"Rt", b"Havungfun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d81c67ac-a79a-43e2-9be3-0db3c805fb7f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RTE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RTE>>(v1);
    }

    // decompiled from Move bytecode v6
}

