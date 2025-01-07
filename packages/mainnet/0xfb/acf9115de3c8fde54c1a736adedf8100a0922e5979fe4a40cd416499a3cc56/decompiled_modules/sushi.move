module 0xfbacf9115de3c8fde54c1a736adedf8100a0922e5979fe4a40cd416499a3cc56::sushi {
    struct SUSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUSHI>(arg0, 6, b"SUSHI", b"SuiShiba", b"SuiShiba is a fun and community-driven memecoin built on the Sui blockchain, blending the playful energy of Shiba Inu with the cutting-edge technology of Sui. Designed to be fast, scalable, and low-cost, SuiShiba brings meme culture into the future of decentralized finance. Whether you're a crypto enthusiast or a meme lover, SuiShiba offers a lighthearted yet powerful token experience that thrives on community engagement and innovation. Join the SuiShiba pack and ride the wave of the next-gen memecoin revolution!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/XXXXX_f5ba96d357.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

