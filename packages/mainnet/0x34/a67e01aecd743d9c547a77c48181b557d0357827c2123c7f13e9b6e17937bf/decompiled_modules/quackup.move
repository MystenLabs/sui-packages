module 0x34a67e01aecd743d9c547a77c48181b557d0357827c2123c7f13e9b6e17937bf::quackup {
    struct QUACKUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUACKUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUACKUP>(arg0, 9, b"QUACK", b"Quackup", x"466f722077696c6420706f7274666f6c696f207377696e6773e28094517561636b757020616c7761797320627265616b73207468652073696c656e636520776974682061206d656d652d776f7274687920686f6e6b20616e642073706c61736821", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigcqp2uno4blgg73ejs6xmy7aeb3c4tqqfcfudhkkg5gv7nnww2qe")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<QUACKUP>(&mut v2, 1000000000000000000, @0x86d23a68cdddbdb748c8d40aa226afed8e5f87c5d5dc8e904c13971759339c73, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUACKUP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QUACKUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

