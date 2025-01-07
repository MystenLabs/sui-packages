module 0xd1581ac22dd13ca41c58e0aedb465874e3ec563b93aebf52424a58891599a48::hah {
    struct HAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAH>(arg0, 6, b"HAH", b"hah", b"hah?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhTqU9VSnZT542BHJlhyphenhyphenFNkW_cRpvnUhlXMEb_LdFcMKoYAocpMmolH329OW1kNVJS1PTHg0N6lmuSDRSL7vQyszD7tVQjOG_8TQAqhR2yDGJ3CqV3x7PXbysbgTaK4x5Da7TAwHb3H-0DVPXRGGMxTwIt3qXczMIR3WBd5buOwa9mtFXP-1Iyqsx7S1Ic/s16000/808%20desktop.gif")), arg1);
        0x2::transfer::public_transfer<0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::Connector<HAH>>(0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::new<HAH>(v0, v1, 0x2::tx_context::sender(arg1), arg1), @0xaf50f089101e7b4650b028d1567aaeb80b42867143cda135a06bf2f4e95815aa);
    }

    // decompiled from Move bytecode v6
}

