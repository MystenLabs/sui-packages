module 0xdc3612af4daf72075e3f7d7efbcebeaac963eeb8e828292d17a5224fb4520f8a::gtcryptola {
    struct GTCRYPTOLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTCRYPTOLA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTCRYPTOLA>(arg0, 9, 0x1::string::utf8(b"GTCRYPTOLA"), 0x1::string::utf8(b"lamba"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn1.telesco.pe/file/aO4tI7AksX3ekPLFY5bRvjWvxj44LJcEmcKUkjFIYK6E_96qG3iLxtSSiF53Si0aNj1lMAkVLFi2hnC2nplgcX4pfODfa-AkDo-zyR1C5qOARzL0e16jYYLK3Zjbp-LyAeZGYre3lY2fORqG_CNTEVZC6GWSNwSjKPg48Qt9maqTlXqYMt1BmlZg7uqX1IJkSSUKKhdX6yU8iHxIZCK-Omhx0DQ7HBfJ4ZZxfDnSGetnOk2RDD0I_x-RWjP0hCvcjxT1vc4Vib2onu2iFaMBynei4ghIIuvH8aOzd9B-C8RUZQaNzJ5e-yuo05fotaTI9JWGPH930NPrbtqwDPQy1w.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTCRYPTOLA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTCRYPTOLA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

