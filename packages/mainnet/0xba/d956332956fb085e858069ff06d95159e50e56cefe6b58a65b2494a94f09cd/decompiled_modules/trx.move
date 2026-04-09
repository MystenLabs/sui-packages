module 0xbad956332956fb085e858069ff06d95159e50e56cefe6b58a65b2494a94f09cd::trx {
    struct TRX has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRX>(arg0, 9, b"TRX", b"WappTron", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/5Zsm1Gi6zoxrHbudy8rA9pUGtMCR4w7CRaXe2pBpZsxZ")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRX>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRX>>(v2, @0xc3849e3ef140cd0d5470ba88a76d127428b62ded765a5baedc3f40e77ca50b95);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRX>>(v1);
    }

    // decompiled from Move bytecode v6
}

