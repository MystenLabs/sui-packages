module 0x65442022c20779c77bb250a5ee9d54d37e0081f1fe66994e494950b9b14c85e9::babyhippo {
    struct BABYHIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYHIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYHIPPO>(arg0, 9, b"BabyHippo", b"Baby Hippo", b"Meme on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2F4222c639_8e82_4ea5_be09_d979ef89f23f_61058fa959.jfif&w=256&q=75")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BABYHIPPO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYHIPPO>>(v2, @0x3e5a78284e4680cb2230cc8de33b29ce19b79ec47c36cf28c8b1b2e3ec44e178);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYHIPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

