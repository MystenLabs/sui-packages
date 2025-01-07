module 0x8f943661a3ec53aa81b8f1fa3ed659a140f7b74ba08a7776e54560b3d283b6a6::af {
    struct AF has drop {
        dummy_field: bool,
    }

    fun init(arg0: AF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AF>(arg0, 9, b"AF", b"RTG", b"AFSD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/80d53f2b-d67f-4bf8-aa50-4a737cef6221.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AF>>(v1);
    }

    // decompiled from Move bytecode v6
}

