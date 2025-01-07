module 0x52bfdbaa6fea8e0e96b4583e9512c96c934d9149389cb256178b0a7fe3add58b::sagardai {
    struct SAGARDAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAGARDAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAGARDAI>(arg0, 9, b"SagarDAI", b"SagarDAI", b"This is Sagar DAI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://media.licdn.com/dms/image/v2/D4D22AQEqpjjg36-Cmw/feedshare-shrink_800/feedshare-shrink_800/0/1725519335245?e=1729123200&v=beta&t=EDvo65aZf1R4OhC0yB-AxLt_hO6DhhXjrg2IvnSDZjI")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SAGARDAI>(&mut v2, 7000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAGARDAI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAGARDAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

