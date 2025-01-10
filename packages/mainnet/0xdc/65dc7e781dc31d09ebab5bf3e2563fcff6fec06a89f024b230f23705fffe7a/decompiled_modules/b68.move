module 0xdc65dc7e781dc31d09ebab5bf3e2563fcff6fec06a89f024b230f23705fffe7a::b68 {
    struct B68 has drop {
        dummy_field: bool,
    }

    fun init(arg0: B68, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B68>(arg0, 9, b"B68", b"Banh", b"Banh 68", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5274dc2f-12d1-4da8-b357-21dbed611379.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B68>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<B68>>(v1);
    }

    // decompiled from Move bytecode v6
}

