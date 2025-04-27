module 0x9b91c268d27121ef5ee2be0153eedbc042f2df159d100673e6473d2fceca06a1::piratehood {
    struct PIRATEHOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIRATEHOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIRATEHOOD>(arg0, 6, b"PIRATEHOOD", b"The PirateHood", x"f09f8fb4e2808de298a0efb88f2024504952415445484f4f4420e2809320546865204c61737420486f6e6573742043726577205361696c696e6720e29a9320f09f9492207472616e73706172656e63792061626f766520616c6c20496e206120776f726c642066756c6c206f66206c616e646c75626265727320616e64207275672070756c6c732c2024504952415445484f4f442073746f726d73206163726f737320746865206469676974616c20736561732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1745765163154.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIRATEHOOD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIRATEHOOD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

