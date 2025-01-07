module 0xdef5ebba4f8b3d04d003ede59d3025587b4ec5c402d0119faf2c820f748dba4a::ownbe {
    struct OWNBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWNBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWNBE>(arg0, 9, b"OWNBE", b"nend", b"bebe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1143ef95-e369-4eb8-8f48-27f0dbfe4a21.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWNBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OWNBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

