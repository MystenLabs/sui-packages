module 0x396bdba3d9645df8aa53c5abc0f328954c4717196233409ddee823a56fde8e45::hds {
    struct HDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HDS>(arg0, 6, b"HDS", b"Hello Dog", b"In 2011, a genius human posted this meme on Tumblr, and because its amazing, it then found a nice little home on Reddit and blew up immediately. The photo of the black labrador on the phone is a still from a 1984 Serbian film called Pejzai u magi, for which we are eternally grateful and definitely didnt know existed before now.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5760_1cc9bf8770.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

