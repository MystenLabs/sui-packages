module 0x1687222ba38286024023d94b13cf70131f37a7dac832e0679b35e4b02f7dbe36::lunacat {
    struct LUNACAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUNACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUNACAT>(arg0, 6, b"LUNACAT", b"LunaCat on SUI", x"244c554e4143415420697320616e2049524c2063617420776974682065796573206c696b6520676f6c64656e2067656d73746f6e6573206f6e205355490a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ls_GA_Uy_Q7_400x400_1be16d84fe.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUNACAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUNACAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

