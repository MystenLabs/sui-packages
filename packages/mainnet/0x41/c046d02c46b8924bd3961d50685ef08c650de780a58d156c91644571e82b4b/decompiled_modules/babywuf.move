module 0x41c046d02c46b8924bd3961d50685ef08c650de780a58d156c91644571e82b4b::babywuf {
    struct BABYWUF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYWUF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYWUF>(arg0, 9, b"BABYWUF", b"Baby Wuf", b"Popular dog wuf frens - SUI vibe stays on! BABYWUF wuf wuf on", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1839362903021125632/AvgAjw1W_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BABYWUF>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYWUF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYWUF>>(v1);
    }

    // decompiled from Move bytecode v6
}

