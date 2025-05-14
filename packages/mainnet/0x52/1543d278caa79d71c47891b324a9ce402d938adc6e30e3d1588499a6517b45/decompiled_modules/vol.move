module 0x521543d278caa79d71c47891b324a9ce402d938adc6e30e3d1588499a6517b45::vol {
    struct VOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: VOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VOL>(arg0, 6, b"VOL", b"Volo", x"536f6d657468696e672069732062726577696e672c20566f6c6f6e6974657320212121210a537461792074756e656420666f722061206269672072657665616c206e657874207765656b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiczikpxepedz42n4wnti66klg5y3g7k2zpnwah62fsnwfnpbrwnea")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VOL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

