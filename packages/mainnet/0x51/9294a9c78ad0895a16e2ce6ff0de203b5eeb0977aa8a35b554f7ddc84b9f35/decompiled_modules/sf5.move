module 0x519294a9c78ad0895a16e2ce6ff0de203b5eeb0977aa8a35b554f7ddc84b9f35::sf5 {
    struct SF5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SF5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SF5>(arg0, 6, b"SF5", b"Starship Flight 5", b"Starship might fly on Sunday!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20241013160043_e2cb458389.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SF5>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SF5>>(v1);
    }

    // decompiled from Move bytecode v6
}

