module 0x25faf992b02a5362fb3d720f100927d2cc2b952045bf6e71f69dd6d61d4a975d::koban {
    struct KOBAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOBAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOBAN>(arg0, 6, b"KOBAN", b"Lucky Kat", b"KOBAN is the game changing currency powering an interconnected gaming ecosystem. Fuelling titles from Lucky Kat and third-party studios building on our upcoming Takibi Protocol, this token is set to transform the way players interact with games.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreif7a4axppa56vrfmiqhar35c75cejr7nvb6iph6hzgjco6ktqwbgy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOBAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KOBAN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

