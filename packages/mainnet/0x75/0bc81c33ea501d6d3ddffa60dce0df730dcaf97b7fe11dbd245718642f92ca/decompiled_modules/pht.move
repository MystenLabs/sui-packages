module 0x750bc81c33ea501d6d3ddffa60dce0df730dcaf97b7fe11dbd245718642f92ca::pht {
    struct PHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PHT>(arg0, 6, b"PHT", b"Phantom", b"Phantom is a leading meme coin within the Sui ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1742078946305.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PHT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

