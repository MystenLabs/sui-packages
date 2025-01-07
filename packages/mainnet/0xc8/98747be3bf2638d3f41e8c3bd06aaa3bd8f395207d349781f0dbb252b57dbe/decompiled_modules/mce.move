module 0xc898747be3bf2638d3f41e8c3bd06aaa3bd8f395207d349781f0dbb252b57dbe::mce {
    struct MCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCE>(arg0, 9, b"MCE", b"matches", x"49676e69746520796f757220696e766573746d656e74732077697468204d617463686573436f696e3a205468652066696572792063727970746f63757272656e63792074686174277320737061726b696e672070726f6669747320616e64206c69676874696e67207570207468652063727970746f207363656e652077697468206576657279207472616e73616374696f6e2120f09f94a5f09f92b80a54686973206f6e652073686f756c6420737061726b20736f6d6520696e7465726573742120f09f988920496620796f75206e656564206d6f72652c206a757374206c6574206d65206b6e6f7721", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c8d5f533-5b9e-4306-94e3-74256f14287b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

