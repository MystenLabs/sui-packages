module 0xe1da3e8d5bc369572c15327b1f0345faad56d8f5655d5c141395fa78b615d6ba::ssh {
    struct SSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSH>(arg0, 6, b"SSH", b"SuiShibe", b"SuiShibe: The meme coin where laughter meets crypto! Join us in the SuiVerse and turn memes into value and joy! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suishibe_368be7c5d1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

