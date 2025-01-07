module 0xb130615505bb8d7ffcb02704cba2669c8558b76b2a3cb8bdc002f5c9885ec767::patrick {
    struct PATRICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PATRICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PATRICK>(arg0, 9, b"PATRICK", b"Patrick Star", b"The first Patrick Star on $SUI  Let's enjoy together!  TG : https://t.me/sui_patrickstar  X : https://x.com/sui_patrickstar  Website : https://patrickstar.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/patrickstarsui/patrick/refs/heads/main/patrick.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PATRICK>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PATRICK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PATRICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

