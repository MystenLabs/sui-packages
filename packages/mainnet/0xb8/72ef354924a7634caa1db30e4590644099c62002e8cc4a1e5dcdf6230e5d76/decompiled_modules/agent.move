module 0xb872ef354924a7634caa1db30e4590644099c62002e8cc4a1e5dcdf6230e5d76::agent {
    struct AGENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGENT>(arg0, 6, b"Agent", b"Sui First A.I. Agent", b"Sui Fist A.I Agent kraken down on these meme imposters join a winning team and lets take over Sui togethe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8895_f603196f0c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGENT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AGENT>>(v1);
    }

    // decompiled from Move bytecode v6
}

