module 0x38ad272e7cd1197678c8265910bf13a365ca6846ab0a17ea22228619b152eda7::WHALE {
    struct WHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHALE>(arg0, 6, b"WhaleWave", b"WHALE", b"Dive into the deep with WhaleWave, the meme coin that makes a splash! Whether you're a crypto whale or a minnow, ride the wave of decentralized fun and massive gains. Just don't get caught in the FUD tsunami!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://replicate.delivery/xezq/G6K9ejPUArQWciWW6meqA24CPZ9JKQ72YvEU2yeS4egTXevoC/out-0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHALE>>(v0, @0xbdebc33436425c9a7ca66a3b35925621c8885d16b3c741b9ca39527620462511);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHALE>>(v1);
    }

    // decompiled from Move bytecode v6
}

