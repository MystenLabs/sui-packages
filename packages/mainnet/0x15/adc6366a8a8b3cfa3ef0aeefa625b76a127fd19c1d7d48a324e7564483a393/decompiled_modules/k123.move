module 0x15adc6366a8a8b3cfa3ef0aeefa625b76a127fd19c1d7d48a324e7564483a393::k123 {
    struct K123 has drop {
        dummy_field: bool,
    }

    fun init(arg0: K123, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<K123>(arg0, 9, b"K123", b"kj", b"ngay nao la tuyet nhat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/da52d777-c02c-4e42-bddc-a61ce62ce71b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<K123>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<K123>>(v1);
    }

    // decompiled from Move bytecode v6
}

