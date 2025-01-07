module 0x295dd88e019d7611e6194c170a6fdaf1c9731a07f167d213884ec9804dc7faa0::tosuip {
    struct TOSUIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOSUIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOSUIP>(arg0, 6, b"TOSUIP", b"the owl sui pineapple", x"7468652070696e656170706c65206f776c206973207468650a73796d626f6c206f6620776973646f6d20616e640a696e74656c6c6967656e742070656f706c652062757920544f53554950", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_Tela_2024_10_15_a_I_s_14_34_13_9eadb72dcb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOSUIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOSUIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

