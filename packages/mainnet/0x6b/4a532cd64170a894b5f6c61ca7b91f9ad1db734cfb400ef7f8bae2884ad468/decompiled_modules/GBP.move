module 0x6b4a532cd64170a894b5f6c61ca7b91f9ad1db734cfb400ef7f8bae2884ad468::GBP {
    struct GBP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GBP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GBP>(arg0, 6, b"GBP", b"girl blue phone", b"aaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.pexels.com/photos/23656764/pexels-photo-23656764/free-photo-of-tourist-in-a-yellow-raincoat-taking-photos-in-the-rain.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GBP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GBP>>(v1);
    }

    // decompiled from Move bytecode v6
}

