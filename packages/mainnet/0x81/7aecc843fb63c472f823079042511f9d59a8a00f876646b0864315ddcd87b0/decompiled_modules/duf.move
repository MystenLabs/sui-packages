module 0x817aecc843fb63c472f823079042511f9d59a8a00f876646b0864315ddcd87b0::duf {
    struct DUF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUF>(arg0, 9, b"DUF", b"DUF", b"DUF", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DUF>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUF>>(v1);
    }

    // decompiled from Move bytecode v6
}

