module 0xdd7cab69aef86b7dc81b97f245740a3ed9fc919e428c199201f148146bd81c01::oh {
    struct OH has drop {
        dummy_field: bool,
    }

    fun init(arg0: OH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OH>(arg0, 9, b"OH", b"OGZ", b"We have fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0099a77b-2cd3-4b95-b1b1-b915ae22a2fc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OH>>(v1);
    }

    // decompiled from Move bytecode v6
}

