module 0x2fec608d5925ddb006e5e8aa0bcbcab304c60b7d84e2c158f326a693ec321c2d::suido {
    struct SUIDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDO>(arg0, 9, b"SUIDO", b"Suidoge", b"Suidoge is a community-driven meme coin that combines fun with real utility. Join a passionate community driving growth, Buy and trade Suidoge easily on multiple exchanges. Invest today and ride the meme wave!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dc21f7f5-2eb9-4844-a9a6-3d9f3cbb213a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

