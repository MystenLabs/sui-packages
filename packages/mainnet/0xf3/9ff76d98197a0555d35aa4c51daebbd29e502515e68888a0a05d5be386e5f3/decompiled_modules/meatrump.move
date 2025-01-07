module 0xf39ff76d98197a0555d35aa4c51daebbd29e502515e68888a0a05d5be386e5f3::meatrump {
    struct MEATRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEATRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEATRUMP>(arg0, 6, b"Meatrump", b"Meat Trump", x"4e69636520746f206d65617420796f75204d722e20507265736964656e742e200a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7cff48abbb3e3ff918f6e820a9607589_255322844_7552fd7527.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEATRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEATRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

