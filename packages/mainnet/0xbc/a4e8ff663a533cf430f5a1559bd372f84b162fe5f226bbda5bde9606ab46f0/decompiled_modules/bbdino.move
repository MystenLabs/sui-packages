module 0xbca4e8ff663a533cf430f5a1559bd372f84b162fe5f226bbda5bde9606ab46f0::bbdino {
    struct BBDINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBDINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBDINO>(arg0, 6, b"BBDINO", b"Baby Dino", b"Baby Dino is a memecoin based on the Sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736577743037.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBDINO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBDINO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

