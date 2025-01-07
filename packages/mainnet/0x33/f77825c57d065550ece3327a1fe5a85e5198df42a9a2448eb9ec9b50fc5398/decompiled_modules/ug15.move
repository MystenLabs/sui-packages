module 0x33f77825c57d065550ece3327a1fe5a85e5198df42a9a2448eb9ec9b50fc5398::ug15 {
    struct UG15 has drop {
        dummy_field: bool,
    }

    fun init(arg0: UG15, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UG15>(arg0, 9, b"UG15", b"Kanju", b"The purpose of this meme is to provide easiest and simplest way of transaction ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/258d0645-4fdb-475b-a05f-7aad8cb60a7f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UG15>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UG15>>(v1);
    }

    // decompiled from Move bytecode v6
}

