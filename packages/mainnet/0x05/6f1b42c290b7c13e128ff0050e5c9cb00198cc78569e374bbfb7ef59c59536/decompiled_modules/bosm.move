module 0x56f1b42c290b7c13e128ff0050e5c9cb00198cc78569e374bbfb7ef59c59536::bosm {
    struct BOSM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOSM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOSM>(arg0, 9, b"BOSM", b"BookOfSuiMemes", x"426f6f6b4f665375694d656d65732069732061206d656d6520746f6b656e20696e737069726564206279207468652053756920626c6f636b636861696e2c20626c656e64696e672068756d6f7220616e642063727970746f207472656e64732e204974e280997320612066756e2c20636f6d6d756e6974792d64726976656e2070726f6a656374207768657265206d656d657320616e6420637265617469766974792074616b652063656e7465722073746167652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1324467604715499520/nVyuDhZP.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOSM>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOSM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOSM>>(v1);
    }

    // decompiled from Move bytecode v6
}

