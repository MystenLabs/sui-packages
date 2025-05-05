module 0x690488c201550202309871dfa6d0e2f60d4765609916f7069f31442e119d5e7::squirt {
    struct SQUIRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIRT>(arg0, 6, b"SQUIRT", b"SquirtCoin", x"537175697274636f696e206861732074686520736c6f7070696573742067616d652c206772656173696e672053756920757020666f722061207269646520746f20312062696c6c696f6e2e0a0a4865726520746f206d616b652074686520776174657220636861696e206775736820616e64207175697665722e0a0a4e6f2054472c206e6f20636162616c2c2073717569727420667265656c7920616c6c206f7665722074686520626c6f636b636861696e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicpcqitc7u55kpqcxdmvhsqbultofaeixpbmcyloo2tjzvdg44vvq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIRT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SQUIRT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

