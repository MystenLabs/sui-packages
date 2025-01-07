module 0x8ebced6204e279b24c64e1088293dc8523d8237f2b53ba73f51361c5726afb3f::pochita {
    struct POCHITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: POCHITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POCHITA>(arg0, 6, b"POCHITA", b"Pochita on Sui", x"546865203173742024504f4348495441206465706c6f796564206f6e205375692c20636f6d6d756e6974792d6d616e616765642e0a5468652068656972206170706172656e74202e2e2e0a747769747465722e636f6d2f506f6368697461536f6c43544f0a54656c656772616d203a20742e6d652f706f636869746163746f706f7274616c0a5765627369746520203a20742e6d652f706f636869746163746f706f7274616c0a0a4265737420646f672e2e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/O_O_O_U_U_O_U_17_419bb5a45e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POCHITA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POCHITA>>(v1);
    }

    // decompiled from Move bytecode v6
}

