module 0x788b057e8dd65011cd8c707427caed5ff3b274ee529737c76141eb7cb217a898::fas {
    struct FAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAS>(arg0, 9, b"FAS", b"DSG", b"GV", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8c005c85-a580-4c86-909c-0cf5a182f012.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

