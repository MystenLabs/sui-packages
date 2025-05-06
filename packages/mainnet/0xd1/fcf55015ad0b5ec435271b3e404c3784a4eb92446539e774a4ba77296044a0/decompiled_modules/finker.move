module 0xd1fcf55015ad0b5ec435271b3e404c3784a4eb92446539e774a4ba77296044a0::finker {
    struct FINKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: FINKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FINKER>(arg0, 6, b"FINKER", b"FINKERCOIN", b"meme dreams Matt Furie iconic creation FINKER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreid4kp6dwsc3c5broztwilciqwcrt7fxmyx4ocvebpf7hynfrsg6zi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FINKER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FINKER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

