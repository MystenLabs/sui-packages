module 0x7a263ee822080599180fff653ccd5ad52aeb0502215f725da53ed2e6dfb5698b::l3 {
    struct L3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: L3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<L3>(arg0, 9, b"L3", b"Lalala", b"Lalala land", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cc846a52-b61b-442c-8412-3480584ddbaf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<L3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<L3>>(v1);
    }

    // decompiled from Move bytecode v6
}

