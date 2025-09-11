module 0x5d568ccd3d61ad722be1a026f46affad95f45fbb5ea7edebc2fcb7767003e944::noth {
    struct NOTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOTH>(arg0, 9, b"NOTH", b"NOTHING", b"Nothing is impossible", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NOTH>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOTH>>(v2, @0xe00300795155eb1203b642dde5381bb05b835d3f5b4834069b3db41a68050891);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOTH>>(v1);
    }

    // decompiled from Move bytecode v6
}

