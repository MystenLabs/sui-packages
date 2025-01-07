module 0x67aa2f96ceedae366f3b14a9d1a241b719dcda7c3e1cdd844625957370894ee8::catcoin {
    struct CATCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATCOIN>(arg0, 6, b"CATCOIN", b"CatCoin on Sui", x"546865203173742024436174436f696e206465706c6f796564206f6e205375692c20636f6d6d756e6974792d6d616e616765642e0a5468652068656972206170706172656e74202e2e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/O_O_O_U_U_O_U_16_825cf521e4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

