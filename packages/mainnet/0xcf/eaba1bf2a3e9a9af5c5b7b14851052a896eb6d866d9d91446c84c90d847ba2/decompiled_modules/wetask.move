module 0xcfeaba1bf2a3e9a9af5c5b7b14851052a896eb6d866d9d91446c84c90d847ba2::wetask {
    struct WETASK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WETASK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WETASK>(arg0, 9, b"WETASK", b"WEWE task", b"This is for a task lol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f2420d28-db69-4fca-9a86-aac72f058fe4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WETASK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WETASK>>(v1);
    }

    // decompiled from Move bytecode v6
}

