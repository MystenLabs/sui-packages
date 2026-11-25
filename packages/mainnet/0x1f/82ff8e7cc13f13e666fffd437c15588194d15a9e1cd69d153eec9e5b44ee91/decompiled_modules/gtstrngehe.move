module 0x1f82ff8e7cc13f13e666fffd437c15588194d15a9e1cd69d153eec9e5b44ee91::gtstrngehe {
    struct GTSTRNGEHE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTSTRNGEHE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTSTRNGEHE>(arg0, 9, 0x1::string::utf8(b"GTSTRNGEHE"), 0x1::string::utf8(b"AuraZenX"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/k1fUmvjRKOjZD3b1BccBNz_nHNMrUflMccUUVF6qVEOF1_lrQKPTg4Hrb0vttuQmhwDpum1YozaB5YE_REQgZTv7G3HnNnaDbx92WDDr1IJM835BOgPFFFTJ2EFkLweq2ILi1pUz_31MzooiMspNCOzIqWYd-ZRz88SV7aGkZqseK6o2nM99lJu9zvL4KqodTkNBLDyuT_p5_bWPw6Gca_YA--I9JNunuy0-535q2CAMUUu1QxccXJ2JaODQ3hi9XF8JcAq71RIfANdMtE3er3jXMb7voiVF0oVug72e19cw4xVr9qPPCgAZME83fwPQv9LRYfP8FW9CjfqO-xKTtA.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTSTRNGEHE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTSTRNGEHE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

