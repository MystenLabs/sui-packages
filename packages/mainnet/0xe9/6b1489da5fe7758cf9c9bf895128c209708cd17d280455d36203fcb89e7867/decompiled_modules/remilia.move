module 0xe96b1489da5fe7758cf9c9bf895128c209708cd17d280455d36203fcb89e7867::remilia {
    struct REMILIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: REMILIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REMILIA>(arg0, 6, b"Remilia", b"Remilia on Sui", b"Shared by Murad.  Remilia launched on Pumpfun rises 20x now Launch on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sdfsdfsdfd_11dcaefdd7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REMILIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REMILIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

