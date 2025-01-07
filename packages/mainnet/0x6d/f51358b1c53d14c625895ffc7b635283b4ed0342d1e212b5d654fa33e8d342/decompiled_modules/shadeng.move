module 0x6df51358b1c53d14c625895ffc7b635283b4ed0342d1e212b5d654fa33e8d342::shadeng {
    struct SHADENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHADENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHADENG>(arg0, 6, b"SHADENG", b"SHARK MOO DENG", b"Imagine a hippo with a shark's head- a unique and intriguing creature. This hippo has the sturdy, barrel-shaped body and thick legs typical of a hippo, but instead of the usual wide mouth, it boasts the sleek, streamlined head of a shark, complete with sharp teeth and a dorsal fin. The combination of the hippo's massive build and the shark's predatory features makes for an astonishing and awe-inspiring sight.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000116111_002a090249.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHADENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHADENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

