module 0x4cc3951c540cf57b3e5f6744d0f2ee10cadae0176712bf071492c38f3e2c430::aaa {
    struct AAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAA>(arg0, 9, b"AAA", b"AAA Token", b"This is test token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dev-file-walletapp.waveonsui.com/images/wave-pumps/71db37e0-dbae-4e41-9d3f-de84c71d6eec.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

