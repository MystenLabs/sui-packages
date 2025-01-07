module 0xc01dc9ec785d61302ab66c124aec4c33a3a7c69121f0c64ad942fab8d7a4adae::pepetrump {
    struct PEPETRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPETRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPETRUMP>(arg0, 6, b"PEPETRUMP", b"PEPE TRUMP", b"\"Pepe Trump\" combines Donald Trump with the internet meme Pepe the Frog. Pepe, created by Matt Furie, gained online fame and became associated with Trump supporters during the 2016 U.S. presidential election, often depicted wearing a \"Make America Great Again\" hat in memes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://tomato-deep-eel-22.mypinata.cloud/ipfs/QmWmR8vVCPD7M61WtCe8CNkDh5aZrbAN4s5PwiDGicqSYU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PEPETRUMP>(&mut v2, 8000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPETRUMP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPETRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

