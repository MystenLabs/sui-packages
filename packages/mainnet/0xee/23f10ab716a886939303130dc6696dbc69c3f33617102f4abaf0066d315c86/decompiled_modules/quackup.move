module 0xee23f10ab716a886939303130dc6696dbc69c3f33617102f4abaf0066d315c86::quackup {
    struct QUACKUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUACKUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUACKUP>(arg0, 9, b"QUACK", b"Quackup", x"466f722077696c6420706f7274666f6c696f207377696e6773e28094517561636b757020616c7761797320627265616b73207468652073696c656e636520776974682061206d656d652d776f7274687920686f6e6b20616e642073706c61736821", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigcqp2uno4blgg73ejs6xmy7aeb3c4tqqfcfudhkkg5gv7nnww2qe")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<QUACKUP>(&mut v2, 1000000000000000000, @0x72c767ff9daadbf73e24475876ba497a7bc211f59e49cc673f495dd24420383b, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUACKUP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QUACKUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

