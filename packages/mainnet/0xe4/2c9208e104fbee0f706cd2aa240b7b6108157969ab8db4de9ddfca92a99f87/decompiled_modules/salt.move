module 0xe42c9208e104fbee0f706cd2aa240b7b6108157969ab8db4de9ddfca92a99f87::salt {
    struct SALT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SALT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SALT>(arg0, 6, b"SALT", b"SALTY", b"SEA SALT ($SALT) is a fun and community-driven meme token sailing on the waves of the Sui blockchain. Just like salt is essential for flavor, $SALT adds spice to the crypto world by embodying the spirit of lightheartedness and creativity. Whether youre a seasoned trader or new to the seas of decentralized finance, $SALT is here to unite crypto enthusiasts in a playful, yet meaningful way.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SEA_SALT_b9760c38c3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SALT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SALT>>(v1);
    }

    // decompiled from Move bytecode v6
}

