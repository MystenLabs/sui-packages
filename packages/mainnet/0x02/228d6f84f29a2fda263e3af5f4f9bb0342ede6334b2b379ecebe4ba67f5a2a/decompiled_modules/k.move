module 0x2228d6f84f29a2fda263e3af5f4f9bb0342ede6334b2b379ecebe4ba67f5a2a::k {
    struct K has drop {
        dummy_field: bool,
    }

    fun init(arg0: K, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<K>(arg0, 9, b"K", b"Trumb", b"Trumb to win", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f6ad3b99-ed75-4b2a-a699-276391c9b97d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<K>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<K>>(v1);
    }

    // decompiled from Move bytecode v6
}

