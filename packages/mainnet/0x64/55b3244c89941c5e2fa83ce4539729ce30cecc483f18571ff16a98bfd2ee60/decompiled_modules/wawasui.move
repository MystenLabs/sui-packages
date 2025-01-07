module 0x6455b3244c89941c5e2fa83ce4539729ce30cecc483f18571ff16a98bfd2ee60::wawasui {
    struct WAWASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAWASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAWASUI>(arg0, 9, b"WAWASUI", b"WAWA", b"She wawa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dc014d6c-0bc8-4581-9f28-84f01a3923ff.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAWASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAWASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

