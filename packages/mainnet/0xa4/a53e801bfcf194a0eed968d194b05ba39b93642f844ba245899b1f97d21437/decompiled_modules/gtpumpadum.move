module 0xa4a53e801bfcf194a0eed968d194b05ba39b93642f844ba245899b1f97d21437::gtpumpadum {
    struct GTPUMPADUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTPUMPADUM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTPUMPADUM>(arg0, 9, 0x1::string::utf8(b"GTPUMPADUM"), 0x1::string::utf8(b"Pumpamentals"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/o6TnuRDbcZbgcqMHYGjcmll_WGtdNQ43gokUmT4EYY3QKz3kDZCfBbaZeM2FDTouMKFJ_7lTOfXJihcC3ejzDxyjHH7UN7r7YYmpr_qzJ0DoDaGBRrvL3Qoi4lAqNDKKS5-eIHT5SOqxhw627MlvVATyZVTFIURs9ZsxK4I-18PAhIBfxaeK636ma-VFJd5tnbsh-02TaFRnfe-oEmmfoARZ9CYFtl9LHmL9rMz6iEF0g50JydMA4HsWL9Fly59f6r2wM7KhI0qygGliEagbJCIq7PSf_LPeZdaU1b9LAap5LftRqquekOEoAjSqk4shNWawS7S1SQsL0LQVAkRjzg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTPUMPADUM>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTPUMPADUM>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

