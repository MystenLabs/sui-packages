module 0x9c110a162b81fe443df2ad86fc6e528ab5c191610acd03b6588d19c7fd3485e1::pira {
    struct PIRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIRA>(arg0, 9, b"PIRA", b"Piranha ", x"506972616e6861204669736820282024504952412920697320796f757220666561726c65737320646566656e6465722c206c75726b696e6720696e2074686520537569204f6365616e2c20726561647920746f2074616b6520612062697465206f7574206f6620677265656479207768616c657320616e6420726564697374726962757465207765616c746820746f2074686f73652077686f207472756c79206e6565642069742e204e6f20736861647920696e666c75656e636572732c206e6f206d61726b6574206d616e6970756c6174696f6ee280946a7573742061206661697220666967687420666f7220616c6c21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e5bdac82-58f3-4244-9ce9-78b7e398b041.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

