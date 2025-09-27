module 0x78b86485d4322097edfdc31fef6e1218c31c46d1a10fb96a5f7b7135a5296a3e::up {
    struct UP has drop {
        dummy_field: bool,
    }

    fun init(arg0: UP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UP>(arg0, 6, b"Up", b"Uptober", x"546869732069736ee2809974206a757374204f63746f6265722e2054686973206973205570746f62657220e2809420746865206d6f6e74682077686572652062656c696576657273207269736520616e64206d61726b657473206d6f76652e205468652073686966742073746172747320686572652c207769746820746869732063727970746f2e2047657420726561647920746f20726964652074686520776176652e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1758998014975.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

