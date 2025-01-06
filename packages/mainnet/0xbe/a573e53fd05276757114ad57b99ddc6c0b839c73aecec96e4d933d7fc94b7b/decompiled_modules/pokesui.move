module 0xbea573e53fd05276757114ad57b99ddc6c0b839c73aecec96e4d933d7fc94b7b::pokesui {
    struct POKESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKESUI>(arg0, 6, b"POKESUI", b"Pokemon sui", b"Pokesui is a decentralized revolutionary memecoin that's ambitioned to takeover the Sui memespace. It's inspired by the infamous Pokemon franchise. It has one goal, to dominated the Sui Network and be the leading memecoin along with its core attributes of being fun, exciting, creative, and safe for the community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_b35eafa0de.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POKESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

