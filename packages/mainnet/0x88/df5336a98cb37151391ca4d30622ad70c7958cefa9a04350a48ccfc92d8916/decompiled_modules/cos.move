module 0x88df5336a98cb37151391ca4d30622ad70c7958cefa9a04350a48ccfc92d8916::cos {
    struct COS has drop {
        dummy_field: bool,
    }

    fun init(arg0: COS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COS>(arg0, 6, b"COS", b"Creator of sui", b"Jsjs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihvgbopv62nh3cy6brvwtjwyqht4svjo6rbge6x2rwinn5vrsldje")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<COS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

