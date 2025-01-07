module 0x3507be05b76c543fa157c07642b997ca26f2f4a92f5beb0ef9e93ff4d8e043c::kkk {
    struct KKK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KKK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KKK>(arg0, 9, b"kkk", b"kl", b"k", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KKK>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KKK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KKK>>(v1);
    }

    // decompiled from Move bytecode v6
}

