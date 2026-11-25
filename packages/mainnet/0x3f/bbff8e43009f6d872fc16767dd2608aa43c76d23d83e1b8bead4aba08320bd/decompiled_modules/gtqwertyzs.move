module 0x3fbbff8e43009f6d872fc16767dd2608aa43c76d23d83e1b8bead4aba08320bd::gtqwertyzs {
    struct GTQWERTYZS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTQWERTYZS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTQWERTYZS>(arg0, 9, 0x1::string::utf8(b"GTQWERTYZS"), 0x1::string::utf8(b"Peepo"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn5.telesco.pe/file/s3yT_cVkj6i909A6kgAiYie4Y0cLFp_PHjWnCEpzzBF-fj74raNgpesDpM_jw6ArMrPtOniv-zvvk7c7YngIFtuZJhnJMkG8LA-Oa6CNtemOwANxOYuPMq0q42nE8p7ZTKt5NRh50oijnWZWZEcjNe5PBcWu6vqvRw_UtYP3TYjPh9yVZPe9SCeyWr7Pso9VF0hNgo2MxFSH1rZeJ9SlkKyo9LsAdStZbYzFmWpyIDTaVshvVfFje5TDxO7x6rvg1hrTN6OuKhtTz7TfrdPYKpyyh4M4MY-AWLumUoT5dyxH5ZSGD6a_gJabwcnOIPmnia2nBkQB7czIAnxN7ilhNQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTQWERTYZS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTQWERTYZS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

