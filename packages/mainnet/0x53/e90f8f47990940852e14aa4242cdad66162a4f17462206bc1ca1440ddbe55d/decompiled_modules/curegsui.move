module 0x53e90f8f47990940852e14aa4242cdad66162a4f17462206bc1ca1440ddbe55d::curegsui {
    struct CUREGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUREGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUREGSUI>(arg0, 6, b"CUREGSUI", b"CUREG SUI DUG", x"4375726567206973206120706f70756c61722039307320636172746f6f6e2e20486520697320612074696d69642070696e6b20646f67207769746820706172616e6f69612070726f626c656d732e20486973206f776e6572732061726520616e206f6c6420636f75706c65206c6976696e67206f6e2061206661726d2066756c6c206f662062697a617272652061647665727361726965732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Imagem_do_Whats_App_de_2024_10_16_A_s_14_54_58_979ff5cc_10d4de34fe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUREGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CUREGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

