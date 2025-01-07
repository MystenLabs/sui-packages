module 0x41bcba90f1bc89bcb6f4920f68abd5515ba7fad2f141ca45750ac3172d6bc7f::lve {
    struct LVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LVE>(arg0, 9, b"LVE", b"Love", b"Let it lead", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c8c40189-b771-4af5-ada7-f8a2bd0f705e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

