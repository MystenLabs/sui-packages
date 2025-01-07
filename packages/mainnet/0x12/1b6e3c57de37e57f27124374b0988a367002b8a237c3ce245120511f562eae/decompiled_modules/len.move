module 0x121b6e3c57de37e57f27124374b0988a367002b8a237c3ce245120511f562eae::len {
    struct LEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEN>(arg0, 6, b"LEN", b"Len Sassaman", b"The Len Sassaman Token (LST) is a tribute to the late Len Sassaman, a renowned cryptographer and privacy advocate whose work significantly contributed to online privacy and cryptographic technology. This token, created on the Sui blockchain, honors his legacy by promoting secure, decentralized solutions and inspiring future innovations in privacy and cryptography.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/len_73a509a05d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

