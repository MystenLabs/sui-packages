module 0x9a5c9a1e211391cc8ae64b0ca25328b1f642b785aa089527465c0c0a7ec2db8a::bubbly {
    struct BUBBLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBBLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBBLY>(arg0, 6, b"BUBBLY", b"Bubbly", b"Bubbly, your Sui Buddy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bubble_PFP_ef103e5d74.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBBLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBBLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

