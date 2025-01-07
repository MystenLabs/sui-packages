module 0xfba6c25afc4a4f1d8479db85d429df9e0b80e0ef7b7d23509a4a7c6e0c53af24::dopi {
    struct DOPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOPI>(arg0, 6, b"Dopi", b"DOPI", b"Dopi is an exciting memecoin set to launch on the Sui network. With the upcoming launch on MovePump, we are ready to make a splash in the cryptocurrency world. Join us on this thrilling journey and discover the potential Dopi has to offer!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241031_051805_ee5dc134ff.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

