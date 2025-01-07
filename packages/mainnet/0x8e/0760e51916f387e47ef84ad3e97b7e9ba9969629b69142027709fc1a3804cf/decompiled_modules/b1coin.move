module 0x8e0760e51916f387e47ef84ad3e97b7e9ba9969629b69142027709fc1a3804cf::b1coin {
    struct B1COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: B1COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B1COIN>(arg0, 6, b"B1COIN", b"wen lamba on sui", b"- WEN LAMBA, SIR?- JUST BUY THIS FCKIN $BICOIN!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Frame_99_582a0b91b8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B1COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B1COIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

