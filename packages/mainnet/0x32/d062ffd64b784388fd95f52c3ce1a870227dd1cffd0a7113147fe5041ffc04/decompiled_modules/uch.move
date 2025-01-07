module 0x32d062ffd64b784388fd95f52c3ce1a870227dd1cffd0a7113147fe5041ffc04::uch {
    struct UCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: UCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UCH>(arg0, 9, b"UCH", b"Uchiho", b"UCHIHO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/db2974cc-5ef7-4dd9-a831-48db59f9eff3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

