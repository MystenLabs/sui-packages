module 0xadb5a606f1088a93101e1a225dfcfebf39076d33b7fd308b9e364bacbfc1e9fb::kp {
    struct KP has drop {
        dummy_field: bool,
    }

    fun init(arg0: KP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KP>(arg0, 9, b"KP", b"Kipaska", b"Kipaska Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/24fd9d4b-1b54-46cc-90da-c68ac52ba472.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KP>>(v1);
    }

    // decompiled from Move bytecode v6
}

