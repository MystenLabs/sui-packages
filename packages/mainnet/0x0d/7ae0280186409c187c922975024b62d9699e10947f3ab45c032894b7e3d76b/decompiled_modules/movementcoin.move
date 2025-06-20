module 0xd7ae0280186409c187c922975024b62d9699e10947f3ab45c032894b7e3d76b::movementcoin {
    struct MOVEMENTCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVEMENTCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVEMENTCOIN>(arg0, 6, b"Movementcoin", b"Movement coin", b"Movement coin will send sui on moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiftpldvd6kwxq56pjtpcsydrg65b57efwiaw6uz2xon3do45ovyxe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVEMENTCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOVEMENTCOIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

