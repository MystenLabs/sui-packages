module 0x66eec9927bf99b29b4d20e68ed8155a91570007265dac3181bd7b104aa6c0df4::gtcyberdol {
    struct GTCYBERDOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTCYBERDOL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTCYBERDOL>(arg0, 9, 0x1::string::utf8(b"GTCYBERDOL"), 0x1::string::utf8(b"Cyber Dolphin"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/Xfi2bQ4X2LrGiolkJujrEuTorL1d-be5krrGzohzcmWT3Kz0TYOFlnGRO6jJq8kLrVpoodcyLchR5KjtfBw1yRhPFo7xnZOmepzK79t7rPka9AZN_0KfEQHd2l75W5l4qKfLdG1rgPwjrRGI4-_h2vnJrpZLcBpYUFx6qrI7pl0fe63sm7PYnjhJVW2HDS1bCrAVzGqy_E0uHOJufbSgNTFh13LVPFfAwsr3vghOuc9UABA1uxQfhTmxlhj8IC-yp4xamXpY9XtbcD36-Vl1i739nyV3NXRjFAAIg9LCLzwvQu7QU5j7F_0rFLxWZVZwYLqgVQ3I0XZ7bz-yCh5BEg.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTCYBERDOL>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTCYBERDOL>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

