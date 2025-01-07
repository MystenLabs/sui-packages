module 0xb76cf82a5cf78cb6626ca5596dd00ca12008aa05c6f8c6d9b7a4003d4c705396::ftc {
    struct FTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: FTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FTC>(arg0, 6, b"FTC", b"For The Community", x"5369636b206f66206265696e67207275676765642062792073656c666973682070656f706c652e20536f206c65742773206275696c64207468697320746f676574686572206173206120636f6d6d756e69747920616e642073656520686f77206661722077652063616e20676f210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A_Nr_R_Epho_400x400_f41bac0c4b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

