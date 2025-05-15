module 0xc296f5a589b6cd7cf6e42f6a24dba839ac82482e4e368c8cb2faa0b65215783a::bla {
    struct BLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLA>(arg0, 6, b"BLA", b"balblab", b"adfad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibabt6bfgm2yci7epzsvnqihs6n77fe5fuiljpfo7vizfur2v5yem")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

