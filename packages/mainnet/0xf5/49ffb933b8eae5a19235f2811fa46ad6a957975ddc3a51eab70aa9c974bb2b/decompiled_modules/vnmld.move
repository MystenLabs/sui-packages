module 0xf549ffb933b8eae5a19235f2811fa46ad6a957975ddc3a51eab70aa9c974bb2b::vnmld {
    struct VNMLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: VNMLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VNMLD>(arg0, 9, b"VNMLD", b"Venom: The Last Dance", b"Venom: The Last Dance is a 2024 American superhero film written and directed by Kelly Marcel, which features the Marvel Comics character Venom. A sequel to Venom: Let There Be Carnage, it is the fifth film in Sony's Spider-Man Universe (SSU) and the final film in the Venom trilogy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://upload.wikimedia.org/wikipedia/en/a/a3/Venom_The_Last_Dance_Poster.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<VNMLD>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VNMLD>>(v2, @0xebc707141970574ece90991112fe9a682d03b1596db6ca8981a29f385cbf76d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VNMLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

