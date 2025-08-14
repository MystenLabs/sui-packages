module 0x8cbe2a9f42a4044e45155417d781b5c646041f4f2c9f83094fd8ed642000868e::BEARZ {
    struct BEARZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEARZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEARZ>(arg0, 6, b"Bearzz", b"BEARZ", b"A meme coin inspired by the wild and playful spirit of animated bears. BEARZ brings the fun of cartoons to the crypto world, with a community-driven approach and a focus on humor, creativity, and nostalgia. Join the bear hug!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://w3s.link/ipfs/bafkreiafucehagduvnxqfmam4repl5xdqgsx2wssllus76omad6fn23f6a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEARZ>>(v0, @0x2be6c850562754e11af55b7f049f4e304e488dff630b3832874d80c837c458a8);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEARZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

