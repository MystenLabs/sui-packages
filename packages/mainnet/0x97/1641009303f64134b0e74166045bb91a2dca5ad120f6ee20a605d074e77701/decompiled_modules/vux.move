module 0x971641009303f64134b0e74166045bb91a2dca5ad120f6ee20a605d074e77701::vux {
    struct VUX has drop {
        dummy_field: bool,
    }

    fun init(arg0: VUX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VUX>(arg0, 6, b"VUX", b"VUX", b"Vuxxx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafkreiaylgip6ksbcknf7tmatvamln4xsmlionnp3zu67blmbf4xveepse")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<VUX>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VUX>>(v2, @0xfe65cf3f401586ad76108d97b4a49fa382c3b16235f36e0fc972035b25414e9e);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VUX>>(v1);
    }

    // decompiled from Move bytecode v6
}

