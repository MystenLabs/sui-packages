module 0xff16397dfab96c1fdb2bd10967feaa81f7d3ca976be8923fcb99ad4b748058a0::freak {
    struct FREAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FREAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FREAK>(arg0, 6, b"Freak", b"Freak V2", b"Born from the shadows of the blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiagzoxkfscsmimucgvezudqg62sq2tobz5iamkp7zzeatxnf2m5xi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FREAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FREAK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

