module 0x804bca8cb9a9c662e2fc55d6cebeddf1ac2c52d259be8c93cf9707234cba5489::hui {
    struct HUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUI>(arg0, 6, b"Hui", b"HuionSui", x"22485549204855493a20776865726520657665727920696e766573746d656e7420697320612070756e63686c696e652c20616e6420796f757220706f7274666f6c696f206973206a7573742061206a6f6b652077616974696e6720746f2068617070656e2e220a0a5468697320636f696e2069732064657369676e656420666f722074686f73652077686f2066696e642068756d6f7220696e2066696e616e6369616c206368616f732e20456e6a6f7920746865207269646521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hui_7f7bb83f43.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

