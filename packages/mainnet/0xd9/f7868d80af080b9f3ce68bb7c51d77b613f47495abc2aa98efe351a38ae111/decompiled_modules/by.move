module 0xd9f7868d80af080b9f3ce68bb7c51d77b613f47495abc2aa98efe351a38ae111::by {
    struct BY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BY>(arg0, 9, b"BY", b"Boy", b"A happy cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8ca5b2e6-ed2b-4282-87b1-ca8762a77f7a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BY>>(v1);
    }

    // decompiled from Move bytecode v6
}

