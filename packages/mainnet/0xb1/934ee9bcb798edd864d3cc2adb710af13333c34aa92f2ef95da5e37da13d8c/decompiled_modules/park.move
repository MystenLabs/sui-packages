module 0xb1934ee9bcb798edd864d3cc2adb710af13333c34aa92f2ef95da5e37da13d8c::park {
    struct PARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PARK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PARK>(arg0, 6, b"PARK", b"Sauth PARK by SuiAI", x"43727970746f20616e616c797a6572207573696e67204149207265617361726368206f6e20736f6369616c206d656469612e2e43727970746f204149206167656e74732063616e206175746f6d617465207461736b73206c696b6520616e616c797a696e6720626c6f636b636861696e20646174612c20747261636b696e6720736f6369616c206d65646961207472656e64732c20616e6420657865637574696e672074726164657320e28094206d616b696e672063727970746f20696e76657374696e6720656173696572207468616e20657665722120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/shity_coin_9574034577.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PARK>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PARK>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

