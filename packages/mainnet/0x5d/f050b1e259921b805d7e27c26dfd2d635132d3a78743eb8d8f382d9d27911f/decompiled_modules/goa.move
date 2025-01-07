module 0x5df050b1e259921b805d7e27c26dfd2d635132d3a78743eb8d8f382d9d27911f::goa {
    struct GOA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOA>(arg0, 9, b"GOA", b"goat", b"goats fake roken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/04b50990-fb47-46ac-ad0a-f12e1630cfd8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOA>>(v1);
    }

    // decompiled from Move bytecode v6
}

