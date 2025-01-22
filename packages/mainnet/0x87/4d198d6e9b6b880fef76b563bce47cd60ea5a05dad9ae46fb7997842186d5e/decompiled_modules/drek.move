module 0x874d198d6e9b6b880fef76b563bce47cd60ea5a05dad9ae46fb7997842186d5e::drek {
    struct DREK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DREK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DREK>(arg0, 6, b"DREK", b"Drek", b"Drek is an innovative memecoin on the Sui blockchain that combines humor with the simplicity of a farmers life. Inspired by the hard work and wisdom of past generations, Drek is designed to entertain while fostering a strong community within the ever-evolving crypto ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000046404_656df8e2b2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DREK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DREK>>(v1);
    }

    // decompiled from Move bytecode v6
}

