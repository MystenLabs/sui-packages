module 0xb4e42f5dd46c7c3bd3692997ea7b6ee464e1dbc94cdb824e0a8f0a4ce4f2aa7d::thc {
    struct THC has drop {
        dummy_field: bool,
    }

    fun init(arg0: THC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THC>(arg0, 9, b"THC", b"T.H.C", b"if you love thc formula you will love it's coin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a2f3d6df-6cbc-4075-bd89-2bad5121650b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THC>>(v1);
    }

    // decompiled from Move bytecode v6
}

