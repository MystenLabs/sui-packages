module 0x31b9c46905230dcdb42a6d2144439042af9c2fc503ad7c5ee15d41b44626c01b::vensui {
    struct VENSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: VENSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VENSUI>(arg0, 6, b"VenSui", b"Venom On Sui", b"To each and every one of you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeig2qn7u4fvvz6enbheah6xpgpexbyxoxoynkqorf3vhkenwui5svy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VENSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VENSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

