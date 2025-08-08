module 0xb671f3b5d3feced8b4f907b2a66b99f1b4551566a22e5da11b0936392440090b::beg {
    struct BEG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEG>(arg0, 6, b"BEG", b"BEGLORD", b"BEGLORD is not just another meme token ,it a symbol of vibes, chaos, and pure community power born on the SUI blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeib3vjazl5kbykxiurv3usoj4xnx5dng6l3bilpnoe7z55vfs6ntpq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BEG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

