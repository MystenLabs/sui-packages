module 0xc44722d45dbdf8e5d6cb729d5cab6de1b3de681d23faf4c19ecde06c2bcfb92e::wc {
    struct WC has drop {
        dummy_field: bool,
    }

    fun init(arg0: WC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WC>(arg0, 6, b"WC", b"WRAPPED CAT", x"4a5553542057524150504544204341540a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ADAE_Xa6_N_400x400_95771fedbe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WC>>(v1);
    }

    // decompiled from Move bytecode v6
}

