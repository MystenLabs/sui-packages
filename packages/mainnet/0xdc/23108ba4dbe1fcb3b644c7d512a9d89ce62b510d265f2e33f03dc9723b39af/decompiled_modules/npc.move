module 0xdc23108ba4dbe1fcb3b644c7d512a9d89ce62b510d265f2e33f03dc9723b39af::npc {
    struct NPC has drop {
        dummy_field: bool,
    }

    fun init(arg0: NPC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NPC>(arg0, 6, b"NPC", b"Sui Npc", b"Non Playable coin on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidos73drpom33hhbxxw3j4fq4sd6dud2v563ryzwob557b54tchuu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NPC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NPC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

