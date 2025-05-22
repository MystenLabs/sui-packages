module 0xf264ffdf4e412d540a0d259e97162179c9623a0b461eaca6881e58b17097c6a3::zozo {
    struct ZOZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZOZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZOZO>(arg0, 6, b"ZOZO", b"ZOZO MOON", x"4e455720455241204f46204d454d45530a5a4f5a4f2069732061206d656d6520636f696e206f6e2053756920426c6f636b636861696e2077697468203020746178206f6e2062757920616e642073656c6c732e207369747320616c6f6e677369646520697473206d656d6520636f696e206d61746573205073796475636b20616e64204c6f66692e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreife7npzkxjkofupdhmccf62wb6tjemjas6m4emmrh2ze3hyovt2bq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZOZO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZOZO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

