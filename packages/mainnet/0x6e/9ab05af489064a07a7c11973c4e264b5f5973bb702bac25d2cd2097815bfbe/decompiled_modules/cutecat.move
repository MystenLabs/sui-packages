module 0x6e9ab05af489064a07a7c11973c4e264b5f5973bb702bac25d2cd2097815bfbe::cutecat {
    struct CUTECAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUTECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUTECAT>(arg0, 6, b"CuteCat", b"Cute Cat", b"Cute Cat rises to rule the SUI Blockchain with charm and community power", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihwjptinbngjzob7y5rwpt4b4ttmmwjkgdttdylrbdnfh5soamicy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUTECAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CUTECAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

