module 0x4693c34f08898494c39abd4b136709a820d6402a47dc5e4ed53613a1d83c130f::tu {
    struct TU has drop {
        dummy_field: bool,
    }

    fun init(arg0: TU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TU>(arg0, 9, b"TU", b"TRUMP", b"Meme about DonalTrump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/71326724-6cde-4eb3-b5f2-931c67fbee66.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TU>>(v1);
    }

    // decompiled from Move bytecode v6
}

