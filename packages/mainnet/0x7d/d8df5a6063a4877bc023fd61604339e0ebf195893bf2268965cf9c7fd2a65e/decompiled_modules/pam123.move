module 0x7dd8df5a6063a4877bc023fd61604339e0ebf195893bf2268965cf9c7fd2a65e::pam123 {
    struct PAM123 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAM123, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAM123>(arg0, 6, b"Pam123", b"Pam xinh nhat", b"Pam is new token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibbpohhspaig3vzar6p7mv5uxo33eybeerc3fhglmq4d4jb6dytzq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAM123>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PAM123>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

