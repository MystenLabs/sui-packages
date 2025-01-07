module 0x30957393f9dc3b47c097cd6973bd8bacb27f843f80ad6ea824fae8bf3f7f77dc::blub {
    struct BLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUB>(arg0, 2, b"BLUB", b"BLUB v2 (bridge at: blubv2.com)", b"complete bride", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.cryptorank.io/coins/blub1726144519211.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLUB>(&mut v2, 30000000000000000 * 0x1::u64::pow(10, 2), 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUB>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

