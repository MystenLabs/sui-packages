module 0xb80de4ab9be0103ffef21e0688f5cfe2ba9d5ef2befd7c7831c0ac3f174a9561::tut {
    struct TUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUT>(arg0, 9, b"TUT", b"turtle", b"very tight", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1c288130-dbdd-4997-9820-e30f189cf060.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

