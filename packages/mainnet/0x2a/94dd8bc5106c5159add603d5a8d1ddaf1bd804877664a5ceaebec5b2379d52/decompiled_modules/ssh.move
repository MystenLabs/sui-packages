module 0x2a94dd8bc5106c5159add603d5a8d1ddaf1bd804877664a5ceaebec5b2379d52::ssh {
    struct SSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSH>(arg0, 6, b"SSH", b"SUI SHARK", b"$SSH Meme token on SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9582_758cd918cb.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

