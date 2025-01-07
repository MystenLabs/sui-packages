module 0x7cefbfd424f9bcd52d720fc7ba6e02b44b0aba79b81217e6e7f0cfbb6336aeac::a12 {
    struct A12 has drop {
        dummy_field: bool,
    }

    fun init(arg0: A12, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A12>(arg0, 9, b"A12", b"Aaaa12", b"Hotyoken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/095153eb-c39f-4236-8e6d-7ce19667dbba.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A12>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<A12>>(v1);
    }

    // decompiled from Move bytecode v6
}

