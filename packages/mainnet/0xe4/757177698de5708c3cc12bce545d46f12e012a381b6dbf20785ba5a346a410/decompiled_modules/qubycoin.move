module 0xe4757177698de5708c3cc12bce545d46f12e012a381b6dbf20785ba5a346a410::qubycoin {
    struct QUBYCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUBYCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUBYCOIN>(arg0, 6, b"QUBYcoin", b"Quby", x"436861726163746572697365642062792069747320726f737920636865656b732c2061626e6f726d616c6c79206875676520686561642c20616e6420737469636b2d6c696b65206c696d62732c205175627920686173206265636f6d65206f6e65206f6620746865206d6f73742066616d6f7573206368617261637465727320696e204368696e610a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_05_17_16_49_3cc1bcf901.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUBYCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QUBYCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

