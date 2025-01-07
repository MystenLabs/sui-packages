module 0x9f934fcbeb9a3201e82f3e6926b2f1955379c575116c2db12d37b97197da4793::donger {
    struct DONGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONGER>(arg0, 6, b"DONGER", b"Big Donger", b"Big Donger On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Donger_5262138975.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONGER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONGER>>(v1);
    }

    // decompiled from Move bytecode v6
}

