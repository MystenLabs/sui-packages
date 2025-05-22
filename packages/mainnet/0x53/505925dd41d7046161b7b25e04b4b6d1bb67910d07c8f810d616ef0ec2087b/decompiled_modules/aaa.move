module 0x53505925dd41d7046161b7b25e04b4b6d1bb67910d07c8f810d616ef0ec2087b::aaa {
    struct AAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAA>(arg0, 9, b"AAA", b"AAA Token", b"This is test token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dev-file-walletapp.waveonsui.com/images/wave-pumps/e3e1f3a0-182f-4e6f-9fbe-634d48601f58.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

