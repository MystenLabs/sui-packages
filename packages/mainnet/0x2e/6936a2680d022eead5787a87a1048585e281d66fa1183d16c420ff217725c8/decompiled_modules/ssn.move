module 0x2e6936a2680d022eead5787a87a1048585e281d66fa1183d16c420ff217725c8::ssn {
    struct SSN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSN>(arg0, 9, b"SSN", b"Sniper", b"female dot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a72ad1a8-a608-4d6b-aa26-67417c4c93fb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSN>>(v1);
    }

    // decompiled from Move bytecode v6
}

