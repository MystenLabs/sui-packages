module 0x3c1ed8479a57c96d6808ceb195f5080bcfd97c9d40bd0dab95caf66d88688518::paws {
    struct PAWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWS>(arg0, 6, b"PAWS", b"PAWS UP CULT", x"416e696d616c732061726520646f6e652120497473205041575320536561736f6e200a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000017172_6c03dd5f0b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

