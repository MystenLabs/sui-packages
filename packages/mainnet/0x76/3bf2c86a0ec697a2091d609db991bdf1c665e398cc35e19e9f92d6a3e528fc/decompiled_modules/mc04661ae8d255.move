module 0x763bf2c86a0ec697a2091d609db991bdf1c665e398cc35e19e9f92d6a3e528fc::mc04661ae8d255 {
    struct MC04661AE8D255 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MC04661AE8D255, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MC04661AE8D255>(arg0, 9, b"moon", b"Moon", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MC04661AE8D255>>(v1, v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MC04661AE8D255>>(v0, v2);
    }

    // decompiled from Move bytecode v7
}

