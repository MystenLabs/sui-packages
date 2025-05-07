module 0xcea3024b1d23fd9a3697518cde9bc9412c66548b1810dc9408ce091579e565ae::boom3 {
    struct BOOM3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOM3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOM3>(arg0, 9, b"BOOM3", b"boom3", b"love boom3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://coinhublogos.9inch.io/1724653538838-chum.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOOM3>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOM3>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

