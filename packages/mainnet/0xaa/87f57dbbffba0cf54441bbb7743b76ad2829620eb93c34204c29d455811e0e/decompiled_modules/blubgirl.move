module 0xaa87f57dbbffba0cf54441bbb7743b76ad2829620eb93c34204c29d455811e0e::blubgirl {
    struct BLUBGIRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUBGIRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUBGIRL>(arg0, 6, b"BLUBGIRL", b"BLUBGIRLSUI", b"Blubgirl is Blub Woman.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigungj2wyxpghbwrv5lymcuyvbtixjyxdllxftx2wa3mfxckdchyy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUBGIRL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLUBGIRL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

