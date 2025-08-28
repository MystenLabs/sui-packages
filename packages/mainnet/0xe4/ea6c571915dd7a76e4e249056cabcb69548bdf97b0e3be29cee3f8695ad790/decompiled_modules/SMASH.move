module 0xe4ea6c571915dd7a76e4e249056cabcb69548bdf97b0e3be29cee3f8695ad790::SMASH {
    struct SMASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMASH>(arg0, 6, b"Hulk Smash Coin", b"SMASH", b"A meme coin that packs the punch of the Incredible Hulk! SMASH is all about unstoppable strength, viral growth, and smashing through market resistance. Join the green revolution and HODL for epic gains!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://w3s.link/ipfs/bafkreib25asl75gkbk6ajcjivfyx35zp4vhnlk6344xp4fshvlxdb2ygkm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMASH>>(v0, @0x2be6c850562754e11af55b7f049f4e304e488dff630b3832874d80c837c458a8);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

