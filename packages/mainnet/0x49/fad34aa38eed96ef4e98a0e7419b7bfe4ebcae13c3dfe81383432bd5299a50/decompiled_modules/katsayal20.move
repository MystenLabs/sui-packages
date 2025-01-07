module 0x49fad34aa38eed96ef4e98a0e7419b7bfe4ebcae13c3dfe81383432bd5299a50::katsayal20 {
    struct KATSAYAL20 has drop {
        dummy_field: bool,
    }

    fun init(arg0: KATSAYAL20, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KATSAYAL20>(arg0, 9, b"KATSAYAL20", b"Cats", b"For showing love and care for cats and other pets for being friendly to humans ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/43ad71e7-849f-42fb-b148-d324527dc592.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KATSAYAL20>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KATSAYAL20>>(v1);
    }

    // decompiled from Move bytecode v6
}

