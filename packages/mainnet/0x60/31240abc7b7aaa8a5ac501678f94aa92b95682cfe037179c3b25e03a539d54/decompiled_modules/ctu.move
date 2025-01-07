module 0x6031240abc7b7aaa8a5ac501678f94aa92b95682cfe037179c3b25e03a539d54::ctu {
    struct CTU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTU>(arg0, 9, b"CTU", b"Citybus", b"Meme ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a1535a24-03f3-4174-9706-8e9771f7e8db.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CTU>>(v1);
    }

    // decompiled from Move bytecode v6
}

