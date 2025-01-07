module 0xa963e693cd4719e19577205226645ad5e86f7828c629f804507d058cb2199da4::catcoin {
    struct CATCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATCOIN>(arg0, 6, b"CATCOIN", b"firs catcoin on sui", b"THE FIRST REAL CAT COIN IN HISTORY, BORN IN THE DEPTHS OF THE BTC FORUMS, AND REBORN ON THE SUI BLOCKCHAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/W33_Aozze_400x400_908a4da712.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

