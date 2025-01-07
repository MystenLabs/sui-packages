module 0x55dafe603aa44040d04f0755bf3c8e65974904e35e7e3c21927e5723e1e5c0f5::nato {
    struct NATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NATO>(arg0, 9, b"NATO", b"NATO team", b"North Atlantic Treaty Organization", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c0078cad-7d6a-477c-ba81-a94b9c716142-1000983113.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NATO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NATO>>(v1);
    }

    // decompiled from Move bytecode v6
}

