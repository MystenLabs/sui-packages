module 0x54ef523b7a06de3e7c3faad39791901e25f8ebf40bdab97d490c499355834c30::sbch {
    struct SBCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBCH>(arg0, 6, b"SBCH", b"Sui BitcoinCash", x"73424348202853756920426974636f696e2043617368290a7342434820737461727473207769746820616e206162756e64616e7420737570706c79206275742069732064657369676e656420746f206d6972726f7220426974636f696e2043617368e2809973206c6567656e646172792073636172636974792e205468726f75676820726567756c617220636f696e206275726e732c2074686520746f74616c20737570706c792077696c6c206772616475616c6c7920646563726561736520746f206d6174636820424348e2809973203231206d696c6c696f6e20737570706c7920", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735386757625.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SBCH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBCH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

