module 0xafe79eb3d44e6c90ec7851d7381f5349588d803794822637b6254641917ba674::major {
    struct MAJOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAJOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAJOR>(arg0, 9, b"MAJOR", b"Major Frog", x"4d697374616b65732077657265206d61646520536570742e20362c2032303133207c2031313a323720706d20455354e280a60d0a0d0a412063616d65726120636170747572656420616e20696e7472696775696e672070686f746f206f6620612066726f67206173204e415341e2809973204c414445452073706163656372616674206c69667473206f66662061742057616c6c6f707320466c6967687420466163696c6974790d0a0d0a576173207468697320616e206163636964656e743f20244d414a4f52206b6e6f7773", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.dexscreener.com/cms/images/0JtsDPRgz5EnvmEq")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MAJOR>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAJOR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAJOR>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

