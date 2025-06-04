module 0x7b65589797840e8480b1d4f2afccf5389d81de3c24b6c47c91fae07a92a55793::chonk {
    struct CHONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHONK>(arg0, 6, b"CHONK", b"Chonk Sui", b"He is Chonk Sui protector of chill, guardian of gains, and the ultimate meme overlord of the Sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreickwhe42bpmapsqpxaw7x45v6fmw6zfdclwvil7iccvxibomquhia")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHONK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

