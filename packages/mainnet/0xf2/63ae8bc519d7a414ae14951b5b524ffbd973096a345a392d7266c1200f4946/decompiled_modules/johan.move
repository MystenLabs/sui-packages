module 0xf263ae8bc519d7a414ae14951b5b524ffbd973096a345a392d7266c1200f4946::johan {
    struct JOHAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOHAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOHAN>(arg0, 6, b"Johan", b"Johan liebert", b"Born from the mind of the Monster  .JOHAN is the ultimate psychological meme coin. Cold, calculated, and dangerously charismatic, this token channels the chaos and genius of anime s most iconic villain, Johan Liebert. No roadmap. No mercy. Just pure manipulation on the blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreievtxwx6wuimw5mgv7q2cgc4ragqiow3zq5z7qpwkljwgs3u7weay")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOHAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JOHAN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

