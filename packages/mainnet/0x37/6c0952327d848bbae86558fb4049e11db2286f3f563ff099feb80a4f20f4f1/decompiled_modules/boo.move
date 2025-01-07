module 0x376c0952327d848bbae86558fb4049e11db2286f3f563ff099feb80a4f20f4f1::boo {
    struct BOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOO>(arg0, 9, b"BOO", b"Boohbah", b"Join us as we sing and dance our way to the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/a0b3d23e-5526-43ec-8430-bf12ad0f1a2c/dfr9vph-ce234ddf-813a-42e0-9374-4bcb3005f8e8.png/v1/fill/w_720,h_540,strp/zumbah__boohbah__by_utf1998_dfr9vph-fullview.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9NTQwIiwicGF0aCI6IlwvZlwvYTBiM2QyM2UtNTUyNi00M2VjLTg0MzAtYmYxMmFkMGYxYTJjXC9kZnI5dnBoLWNlMjM0ZGRmLTgxM2EtNDJlMC05Mzc0LTRiY2IzMDA1ZjhlOC5wbmciLCJ3aWR0aCI6Ijw9NzIwIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmltYWdlLm9wZXJhdGlvbnMiXX0.M_BueOSfSMtCD0yKsuBifDyc3TaTUXZp5azT5EP-_L4")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOO>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

