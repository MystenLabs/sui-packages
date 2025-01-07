module 0xf65a5357454d295a733c75e10ea0033a86678d2886c1dd83aa7c61ef5c0d2128::daden {
    struct DADEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DADEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DADEN>(arg0, 9, b"DADEN", b"KTH", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/42bff405-1758-41a9-8892-83d19e054511.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DADEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DADEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

