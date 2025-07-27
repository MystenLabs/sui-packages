module 0x64fa9352535a70379dd963f79495f7683e5c108142abae37344f4e3002616f7b::b_pcto {
    struct B_PCTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_PCTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_PCTO>(arg0, 9, b"bPCTO", b"bToken PCTO", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_PCTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_PCTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

