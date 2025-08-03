module 0xfbab4f250677561d596f34356681fd752d5aa88c9d12407ef154bcf2c391d892::b_scp {
    struct B_SCP has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_SCP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_SCP>(arg0, 9, b"bSCP", b"bToken SCP", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_SCP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_SCP>>(v1);
    }

    // decompiled from Move bytecode v6
}

