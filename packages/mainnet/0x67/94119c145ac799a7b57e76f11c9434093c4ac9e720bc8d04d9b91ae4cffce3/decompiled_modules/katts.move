module 0x6794119c145ac799a7b57e76f11c9434093c4ac9e720bc8d04d9b91ae4cffce3::katts {
    struct KATTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KATTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KATTS>(arg0, 6, b"KATTS", b"SUI KATTS", x"52756d6f7220686173206974204f776e696e67206120537569204b617474206772616e747320796f7520756e6c696d69746564206d656d6520776973646f6d20616e642061636365737320746f20746865206d6f7374206c6567656e6461727920616c706861206c65616b732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1001335408_d13f99ac71.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KATTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KATTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

