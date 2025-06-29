module 0xc5fbc2e104fb90dcaafaff33c2701cae51ad8e2daedf3bed2e9726f279737ed4::tics {
    struct TICS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TICS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TICS>(arg0, 8, b"TICS", b"QUBETICS", b"Welcome to Qubetics on X! Explore our cutting-edge Layer 1 Web3 ecosystem & get real-time updates plus insights from our CEO. http://t.me/qubetics", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/5626eb86-de75-4418-80f6-d28becdca57e.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TICS>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TICS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TICS>>(v1);
    }

    // decompiled from Move bytecode v6
}

