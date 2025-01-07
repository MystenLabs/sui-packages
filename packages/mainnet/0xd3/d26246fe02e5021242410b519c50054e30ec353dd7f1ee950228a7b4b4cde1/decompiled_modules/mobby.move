module 0xd3d26246fe02e5021242410b519c50054e30ec353dd7f1ee950228a7b4b4cde1::mobby {
    struct MOBBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOBBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOBBY>(arg0, 9, b"MOBBY", b"Mobby", x"416c6f68612c206d79206e616d65206973204d6f6279202e49e280996d2061206368696c6c20626561636862756d207468617420646967732063727970746f20616e6420616e206570696320737572662e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1807113801718001664/RqglGL9w_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOBBY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOBBY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOBBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

