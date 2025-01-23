module 0x4485b835b4094355b80037638526e94f95668fdc6108c78b04e567e0edcb80cd::silkroad {
    struct SILKROAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SILKROAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SILKROAD>(arg0, 9, b"SILKROAD", b"SILK ROAD", b"Anonymous Marketplace", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmNeL5fYTjx2rphRgzmEGEd52T13UeskDF8844ZUrafFC4")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SILKROAD>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SILKROAD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SILKROAD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

