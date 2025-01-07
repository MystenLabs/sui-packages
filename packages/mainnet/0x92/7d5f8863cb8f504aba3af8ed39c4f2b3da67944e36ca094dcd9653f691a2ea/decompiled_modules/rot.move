module 0x927d5f8863cb8f504aba3af8ed39c4f2b3da67944e36ca094dcd9653f691a2ea::rot {
    struct ROT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROT>(arg0, 9, b"ROT", b"Rotschild", x"526f74736368696c64202824524f5429206973206e6f74206a75737420616e6f74686572206d656d6520636f696ee280946974e280997320612073746174656d656e742c2061206d6f76656d656e742c20616e6420612073796d626f6c206f662077686174207468652063727970746f2073706163652063616e207472756c79206265207768656e20636f6d62696e656420776974682068756d6f722c2063756c747572652c20616e6420636f6d6d756e6974792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/700f90b0-f5ad-43df-b9ba-92c896b93269.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROT>>(v1);
    }

    // decompiled from Move bytecode v6
}

