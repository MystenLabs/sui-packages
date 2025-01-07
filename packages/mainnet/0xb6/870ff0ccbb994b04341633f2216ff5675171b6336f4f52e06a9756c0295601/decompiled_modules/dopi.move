module 0xb6870ff0ccbb994b04341633f2216ff5675171b6336f4f52e06a9756c0295601::dopi {
    struct DOPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOPI>(arg0, 6, b"Dopi", b"DOPI", b"Dopi is an exciting memecoin set to launch on the Sui network. With the upcoming launch on MovePump, we are ready to make a splash in the cryptocurrency world. Join us on this thrilling journey and discover the potential Dopi has to offer!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241031_051805_4f8c1b9f02.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

