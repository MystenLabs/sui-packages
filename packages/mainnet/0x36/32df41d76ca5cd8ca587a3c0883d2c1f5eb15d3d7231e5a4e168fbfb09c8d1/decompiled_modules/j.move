module 0x3632df41d76ca5cd8ca587a3c0883d2c1f5eb15d3d7231e5a4e168fbfb09c8d1::j {
    struct J has drop {
        dummy_field: bool,
    }

    fun init(arg0: J, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<J>(arg0, 9, b"J", b"Joker", b"Joker Soul", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/86c210aa-6653-4565-a16d-40cba3783770.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<J>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<J>>(v1);
    }

    // decompiled from Move bytecode v6
}

