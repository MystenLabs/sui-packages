module 0x83c1fbab2451acb4f33e069ecf83e690ef2743c701abf65c0d48c330e15423b2::tgb {
    struct TGB has drop {
        dummy_field: bool,
    }

    fun init(arg0: TGB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TGB>(arg0, 9, b"TGB", b"TRT", b"BAZARGOLIKK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/90dcaeb2-c283-4b67-9e59-3df20c014036.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TGB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TGB>>(v1);
    }

    // decompiled from Move bytecode v6
}

