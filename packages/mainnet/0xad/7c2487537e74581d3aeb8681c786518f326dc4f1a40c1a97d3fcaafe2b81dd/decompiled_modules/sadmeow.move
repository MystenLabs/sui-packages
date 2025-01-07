module 0xad7c2487537e74581d3aeb8681c786518f326dc4f1a40c1a97d3fcaafe2b81dd::sadmeow {
    struct SADMEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SADMEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SADMEOW>(arg0, 6, b"SADMEOW", b"Sad Meow On Sui", b"A sad meow ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GSQF_Vsiag_A_Eq_Gn_O_removebg_preview_1f69ef3914.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SADMEOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SADMEOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

