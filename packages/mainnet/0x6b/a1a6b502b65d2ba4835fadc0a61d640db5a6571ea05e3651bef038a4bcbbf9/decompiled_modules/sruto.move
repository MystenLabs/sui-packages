module 0x6ba1a6b502b65d2ba4835fadc0a61d640db5a6571ea05e3651bef038a4bcbbf9::sruto {
    struct SRUTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRUTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRUTO>(arg0, 6, b"SRUTO", b"Suiruto", b"I beat sasuke and fucked Sakura. Dex coming and website too.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiefzjufufzpzm2vmdsjhuary7mzob55pjfox64xkzfi5ujv7yuvfa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRUTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SRUTO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

