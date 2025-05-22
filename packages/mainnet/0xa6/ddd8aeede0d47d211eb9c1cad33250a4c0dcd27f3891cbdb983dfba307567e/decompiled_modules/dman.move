module 0xa6ddd8aeede0d47d211eb9c1cad33250a4c0dcd27f3891cbdb983dfba307567e::dman {
    struct DMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DMAN>(arg0, 6, b"DMAN", b"DOODIE MAN", b"Former Simpsons Animator | OG Web Cartoonist Class of 97 | Founder Whack Your Boss, Whack Your Ex and many more!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreib6k76msmruvreb4estaams547u5hwd75qvv22y5qoakjrugo7q7y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DMAN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

