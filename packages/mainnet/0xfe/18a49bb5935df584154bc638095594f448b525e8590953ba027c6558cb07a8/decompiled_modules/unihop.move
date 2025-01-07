module 0xfe18a49bb5935df584154bc638095594f448b525e8590953ba027c6558cb07a8::unihop {
    struct UNIHOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNIHOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNIHOP>(arg0, 9, b"UNIHOP", b"UniHop", b"The dog of sui co-founder", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1852605727099310080/PtE3sG6I_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<UNIHOP>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNIHOP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNIHOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

