module 0xc214ba4b4dc18a51883b223311e96f64bb17365dfea822fcb6fc81e2b39cb354::ksh {
    struct KSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: KSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KSH>(arg0, 9, b"KSH", b"kushvaha b", b"Tradeble on all plateform", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/721cf16c-db82-4736-ac07-13d72fe30763.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

