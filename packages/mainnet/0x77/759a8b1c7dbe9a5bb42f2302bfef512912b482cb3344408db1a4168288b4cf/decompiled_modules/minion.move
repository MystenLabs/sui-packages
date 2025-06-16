module 0x77759a8b1c7dbe9a5bb42f2302bfef512912b482cb3344408db1a4168288b4cf::minion {
    struct MINION has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINION>(arg0, 6, b"Minion", b"Monions Verse", b"Born from pure meme energy and fueled by community madness, MinionVerse", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie7jn5dfismy6r5uvvka2eyzps3rjnjindjhdghervfk7zbojzuky")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MINION>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

