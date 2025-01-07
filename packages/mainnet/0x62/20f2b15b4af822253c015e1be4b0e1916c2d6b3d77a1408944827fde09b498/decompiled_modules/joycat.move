module 0x6220f2b15b4af822253c015e1be4b0e1916c2d6b3d77a1408944827fde09b498::joycat {
    struct JOYCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOYCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOYCAT>(arg0, 3, b"Joycat", b"JoyCat", b"JoyCat controls the memes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.fife.usercontent.google.com/pw/AP1GczOnJolGDYXpAoKLWiLwVKhzeWf1IemJ86KUkWEWPqUIeCoi1s9ZayaS=w256-h256-s-no-gm?authuser=0")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JOYCAT>(&mut v2, 2200000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOYCAT>>(v2, @0x5c9bb147d9ed48100b208a900ab1f8777035fd303522c941d06d5fbc25d68021);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOYCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

