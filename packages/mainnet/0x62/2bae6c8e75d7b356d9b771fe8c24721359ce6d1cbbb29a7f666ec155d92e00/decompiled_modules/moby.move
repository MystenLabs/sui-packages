module 0x622bae6c8e75d7b356d9b771fe8c24721359ce6d1cbbb29a7f666ec155d92e00::moby {
    struct MOBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOBY>(arg0, 6, b"MOBY", b"Moby", x"4d6f627920656d626f646965732074686520647265616d206c6966657374796c652020736872656464696e672077617665732c2073756e2d6b697373656420626561636865732c2076696272616e74206265616368776561722c20616e64206c6169642d6261636b20656e657267792e2057697468206368696c6c2076696265732c206772656174206c61756768732c20616e64206c6f2d66692062656174732c204d6f627920697320746865206e65772069636f6e206f66205375692e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/moby_icon_16e7d75683.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

